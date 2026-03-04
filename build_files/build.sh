#!/bin/bash

set -ouex pipefail

### Remove unwanted packages

# Remove KDE bloat and other unwanted packages
# Only includes packages actually present in the base image
dnf5 remove -y \
akonadi-server \
akonadi-server-mysql \
kate \
kde-connect \
kio-gdrive \
krfb \
krfb-libs \
kwrite \
libkgapi \
libwinpr \
mpage \
open-vm-tools \
plasma-drkonqi \
plasma-welcome \
python3-boto3 \
samba

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y thunderbird

# Install multimedia codecs and VLC from RPMfusion
dnf5 install -y \
ffmpeg \
gstreamer1-plugins-bad-freeworld \
gstreamer1-plugins-ugly \
gstreamer1-libav \
vlc

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
