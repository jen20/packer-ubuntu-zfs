## Packer Templates for Ubuntu with ZFS Root

This repository contains [Packer][packerio] templates for building Amazon Machine Images for Ubuntu with a ZFS root filesystem. Currently the following distributions are supported:

- Ubuntu 16.04 ("Xenial") LTS
- Ubuntu 16.10 ("Yakkety")

The template is easily modified for Debian distributions, however.

A detailed description of how the template works is available on the [operator-error.com][oe] blog, in the post [Building ZFS Root Ubuntu AMIs with Packer][oepost].

## Running a build

**Note that you'll need the Packer v0.12.3 in order to build these templates.**

Use the `xenial` or `yakkety` targets of the Makefile in root of the repository to build an AMI in `us-west-2`, and copy it to all regions.

The following environment variables must be set in order for the build to succeed:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

## Credits

Thanks to:

- [Scott Emmons][scotte] for [this post][scottepost] about the steps required to build Linux AMIs with a ZFS root filesystem.
- [Sean Chittenden][seanc] for reviewing the template and blog post prior to publication.
- [Zachary Schneider][zachs] for reviewing the template and blog post prior to publication.

[oe]: https://operator-error.com
[oepost]: https://operator-error.com/building-zfs-root-ubuntu-amis-with-packer
[scotte]: https://www.scotte.org
[scottepost]: https://www.scotte.org/2016/12/ZFS-root-filesystem-on-AWS
[seanc]: https://twitter.com/seanchittenden
[zachs]: https://twitter.com/sigil66
[packerio]: https://packer.io
[packerrepo]: https://github.com/mitchellh/packer
