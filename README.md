## Packer Templates for Ubuntu with ZFS Root

This repository contains [Packer][packerio] templates for building Amazon Machine Images for Ubuntu with a ZFS root filesystem. Currently the following distributions are supported:

- Ubuntu 18.04 ("Bionic") LTS with AWS-Optimized Kernel
- Ubuntu 16.04 ("Xenial") LTS with AWS-Optimized Kernel

The template is easily modified for Debian and other recent Ubuntu distributions, however.

You can read about how this template works on the [operator-error.com][oe] blog. Some relevant posts:

- [Building ZFS Root Ubuntu AMIs with Packer][oepost1]
- [Ubuntu 18.04 with Root ZFS on AWS][oepost2]

## Running a build

Use the `bionic` or `xenial` targets of the Makefile in root of the repository to build an AMI in `us-west-2`, and copy it to all regions. Use a recent version of Packer - only the latest available at the time of last editing has been tested (currently: version 1.3.1).

The following environment variables must be set in order for the build to succeed:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

## Credits

Thanks to:

- [Scott Emmons][scotte] for [this post][scottepost] about the steps required to build Linux AMIs with a ZFS root filesystem.
- [Sean Chittenden][seanc] for reviewing the template and blog post prior to publication.
- [Zachary Schneider][zachs] for reviewing the template and blog post prior to publication.

[oe]: https://operator-error.com
[oepost1]: https://operator-error.com/building-zfs-root-ubuntu-amis-with-packer
[oepost2]: https://operator-error.com/2018/10/09/ubuntu-18-04-with-root-zfs-on-aws
[scotte]: https://www.scotte.org
[scottepost]: https://www.scotte.org/2016/12/ZFS-root-filesystem-on-AWS
[seanc]: https://twitter.com/seanchittenden
[zachs]: https://twitter.com/sigil66
[packerio]: https://packer.io
[packerrepo]: https://github.com/hashicorp/packer
