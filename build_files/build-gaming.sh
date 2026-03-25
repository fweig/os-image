#!/bin/bash

set -ouex pipefail

### Remove unwanted packages

# Remove KDE bloat and other unwanted packages
# Only includes packages actually present in the base image
dnf5 remove -y \
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

# this installs a package from fedora repos
dnf5 install -y thunderbird nextcloud-client

### Install Firefox Beta from Mozilla RPM repo
dnf5 config-manager addrepo --id=mozilla --set=baseurl=https://packages.mozilla.org/rpm/firefox --set=gpgkey=https://packages.mozilla.org/rpm/firefox/signing-key.gpg --set=repo_gpgcheck=0
dnf5 makecache --refresh
dnf5 install -y firefox-beta

### Gaming & multimedia packages

dnf5 install -y steam

# Install multimedia codecs, VLC, and Discord from RPMfusion
dnf5 install -y \
  "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
  "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
dnf5 install -y \
discord \
ffmpeg \
gstreamer1-plugins-bad-freeworld \
gstreamer1-plugins-ugly \
gstreamer1-libav \
vlc

#### Enable system services

systemctl enable podman.socket

# Install KDE Rounded Corners effect
dnf5 -y copr enable matinlotfali/KDE-Rounded-Corners
dnf5 install -y kwin-effect-roundcorners
dnf5 -y copr disable matinlotfali/KDE-Rounded-Corners

# Disable native window outline to prevent overlap with rounded corners effect
# Set corner radius to 8 for rounded corners effect
mkdir -p /etc/skel/.config
cat >> /etc/skel/.config/breezerc << 'EOF'
[Common]
OutlineIntensity=OutlineOff
EOF
cat >> /etc/skel/.config/kwinrc << 'EOF'
[Round-Corners]
Size=8
InactiveCornerRadius=8
EOF

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
