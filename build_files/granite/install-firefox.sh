#!/bin/bash
set -ouex pipefail

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
