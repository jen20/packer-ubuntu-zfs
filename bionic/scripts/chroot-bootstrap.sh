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
	zfsutils-linux \
	zfs-initramfs \
	gdisk

# Set the locale to en_US.UTF-8
locale-gen --purge "en_US.UTF-8"
echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale

# Install OpenSSH
apt-get install -y --no-install-recommends openssh-server

# Install GRUB
# shellcheck disable=SC2016
sed -ri 's/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="boot=zfs \$bootfs"/' /etc/default/grub
grub-probe /
grub-install /dev/xvdf

# Configure and update GRUB
mkdir -p /etc/default/grub.d
{
	echo 'GRUB_RECORDFAIL_TIMEOUT=0'
	echo 'GRUB_TIMEOUT=0'
	echo 'GRUB_CMDLINE_LINUX_DEFAULT="console=tty1 console=ttyS0 ip=dhcp tsc=reliable net.ifnames=0"'
	echo 'GRUB_TERMINAL=console'
} > /etc/default/grub.d/50-aws-settings.cfg
update-grub

# Set options for the default interface
cat << EOF > /etc/netplan/eth0.yaml
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: true
EOF

# Install standard packages
DEBIAN_FRONTEND=noninteractive apt-get install -y ubuntu-standard cloud-init
