#!/bin/bash
set -ouex pipefail

rpm --import https://packages.microsoft.com/keys/microsoft.asc

tee /etc/yum.repos.d/vscode.repo > /dev/null <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
autorefresh=1
type=rpm-md
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

dnf5 makecache --refresh
dnf5 --setopt=install_weak_deps=False install -y \
	code \
	socat \
	python3-pip

# install npm
dnf5 install -y \
  curl \
  ca-certificates \
  tar \
  gzip \
  bubblewrap \
  npm

# install tinytex requirements
dnf5 install -y perl wget curl xz tar fontconfig ghostscript
