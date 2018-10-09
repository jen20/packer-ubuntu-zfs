#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o xtrace

# Update APT with new sources
apt-get update

# Do not configure grub during package install
echo 'grub-pc grub-pc/install_devices_empty select true' | debconf-set-selections
echo 'grub-pc grub-pc/install_devices select' | debconf-set-selections

# Install various packages needed for a booting system
DEBIAN_FRONTEND=noninteractive apt-get install -y \
	linux-aws \
	grub-pc \
	zfs-zed \
	zfsutils-linux \
	zfs-initramfs \
	zfs-dkms \
	gdisk

# Set the locale to en_US.UTF-8
locale-gen --purge "en_US.UTF-8"

cat << EOF > /etc/default/locale
LANG="en_US.UTF-8
LANGUAGE="en_US:en"
EOF

# Install OpenSSH
apt-get install -y --no-install-recommends openssh-server

# Install GRUB
# shellcheck disable=SC2016
sed -ri 's/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="boot=zfs \$bootfs"/' /etc/default/grub
grub-probe /
grub-install /dev/xvdf

# Configure and update GRUB
mkdir -p /etc/default/grub.d
cat << EOF > /etc/default/grub.d/50-aws-settings.cfg
GRUB_RECORDFAIL_TIMEOUT=0
GRUB_TIMEOUT=0
GRUB_CMDLINE_LINUX_DEFAULT="console=tty1 console=ttyS0 ip=dhcp tsc=reliable net.ifnames=0"
GRUB_TERMINAL=console
EOF

update-grub

# Set options for the default interface
cat << EOF >> /etc/network/interfaces
auto eth0
iface eth0 inet dhcp
EOF

# Install standard packages
DEBIAN_FRONTEND=noninteractive apt-get install -y ubuntu-standard
DEBIAN_FRONTEND=noninteractive apt-get install -y cloud-init=0.7.7~bzr1212-0ubuntu1
