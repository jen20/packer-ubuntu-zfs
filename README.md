## Packer Templates for Ubuntu with ZFS Root

This repository contains [Packer][packerio] templates for building Amazon Machine Images for Ubuntu with a ZFS root
filesystem. Currently the following distributions are supported:

- Ubuntu 20.04 ("Focal") LTS with AWS-Optimized Kernel
- Ubuntu 18.04 ("Bionic") LTS with AWS-Optimized Kernel
- Ubuntu 16.04 ("Xenial") LTS with AWS-Optimized Kernel

The template is easily modified for Debian and other Ubuntu distributions.

You can read about how this template works on the [jen20.dev][oe] blog. Some relevant posts:

- [Ubuntu 20.04 with Root ZFS on AWS][oepost3]
- [Ubuntu 18.04 with Root ZFS on AWS][oepost2]
- [Building ZFS Root Ubuntu AMIs with Packer][oepost1]

## Differences between versions

As well as installing different versions of the Ubuntu distribution, the templates in this repository have
evolved at different rates. The `focal` template is the most complete, and includes the following changes
compared to other versions:

- Support for AWS NVME device rules
- Support for expanding the ZFS root filesystem via Cloud-Init
- Clearing of the apt-cache as part of the build

These changes could likely be backported to other distributions, but they are mostly there for information
only since I personally only use (and test) the latest LTS distribution for new images.

## Running a build (Focal)

Use the `focal` target of the Makefile in the root of the repository to build an AMI in `us-west-2`. If you wish to copy
the AMI to other regions, edit the template to specify `aws_regions` in the `amazon-ebssurrogate.source` source. It is
also possible to change the region in which the AMI is built directly, though editing `files/sources-us-west-2.list` is
necessary if the initial packages must be obtained from a region other than `us-west-2`.

AWS credentials are sourced from the environment using the standard AWS chain exposed by Packer. The template has only
been tested using v1.6.0 of Packer - the latest available at the time of writing.

## Running a build (Bionic and Xenial)

Use the `bionic` or `xenial` targets of the Makefile in root of the repository to build an AMI in `us-west-2`, and copy
it to all regions. Use a recent version of Packer - version 1.3.1 has been tested.

The following environment variables must be set in order for the build to succeed:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

## Credits

Thanks to:

- [Scott Emmons][scotte] for [this post][scottepost] about the steps required to build Linux AMIs with a ZFS root filesystem.
- [Sean Chittenden][seanc] for reviewing the template and blog post prior to publication.
- [Zachary Schneider][zachs] for reviewing the template and blog post prior to publication.

[oe]: https://operator-error.com
[oepost1]: https://jen20.dev/post/building-zfs-root-ubuntu-amis-with-packer/ 
[oepost2]: https://jen20.dev/post/ubuntu-18.04-with-root-zfs-on-aws/
[oepost3]: https://jen20.dev/post/ubuntu-20.04-with-root-zfs-in-aws/
[scotte]: https://www.scotte.org
[scottepost]: https://www.scotte.org/2016/12/ZFS-root-filesystem-on-AWS
[seanc]: https://twitter.com/seanchittenden
[zachs]: https://twitter.com/sigil66
[packerio]: https://packer.io
[packerrepo]: https://github.com/hashicorp/packer
