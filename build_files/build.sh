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

### Install Firefox Beta from Mozilla
# Download and extract Firefox Beta
curl -L "https://download.mozilla.org/?product=firefox-beta-latest-ssl&os=linux64&lang=en-US" -o /tmp/firefox-beta.tar
mkdir -p /opt/firefox-beta
tar -xf /tmp/firefox-beta.tar -C /opt/firefox-beta --strip-components=1
rm /tmp/firefox-beta.tar

# Disable Firefox updater (can't update in immutable image)
mkdir -p /opt/firefox-beta/distribution
cat > /opt/firefox-beta/distribution/policies.json << 'EOF'
{
  "policies": {
    "DisableAppUpdate": true,
    "ManualAppUpdateOnly": true
  }
}
EOF

# Create desktop file
cat > /usr/share/applications/firefox-beta.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Name=Firefox Beta
Comment=Browse the World Wide Web (Beta)
GenericName=Web Browser
Keywords=Internet;WWW;Browser;Web;Explorer
Exec=/opt/firefox-beta/firefox %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/firefox-beta/browser/chrome/icons/default/default128.png
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
StartupNotify=true
StartupWMClass=firefox-beta
Actions=new-window;new-private-window;

[Desktop Action new-window]
Name=Open a New Window
Exec=/opt/firefox-beta/firefox -new-window

[Desktop Action new-private-window]
Name=Open a New Private Window
Exec=/opt/firefox-beta/firefox -private-window
EOF

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

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
