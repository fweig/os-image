#!/bin/bash

set -ouex pipefail

### Remove unwanted packages
# Only remove packages that are actually present — dnf skips missing ones gracefully
dnf remove -y \
akonadi-server \
akonadi-server-mysql \
firefox \
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
realmd \
samba \
spice-vdagent

### Install packages
dnf install -y thunderbird

### Install Firefox from Mozilla RPM repo
cat > /etc/yum.repos.d/mozilla-firefox.repo << 'EOF'
[mozilla-firefox]
name=Mozilla Firefox
baseurl=https://packages.mozilla.org/rpm/firefox
gpgkey=https://packages.mozilla.org/rpm/firefox/signing-key.gpg
gpgcheck=1
repo_gpgcheck=0
enabled=1
EOF
dnf makecache --refresh
dnf install -y firefox

### Install multimedia codecs and VLC from RPMfusion
dnf install -y \
  "https://download1.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm" \
  "https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm"
dnf install -y --allowerasing \
ffmpeg \
gstreamer1-plugins-bad-freeworld \
gstreamer1-plugins-ugly \
gstreamer1-libav \
vlc

#### Enable system services
systemctl enable podman.socket

### Force Konsole dark mode for all users
mkdir -p /etc/skel/.config
cat > /etc/skel/.config/konsolerc << 'EOF'
[UiSettings]
ColorScheme=BreezeDark
EOF

### Disable SELinux and Spectre mitigations for performance
mkdir -p /usr/lib/bootc/kargs.d
cat > /usr/lib/bootc/kargs.d/10-performance.toml << 'EOF'
kargs = ["selinux=0", "mitigations=off"]
EOF
