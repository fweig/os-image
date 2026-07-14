#!/bin/bash
set -ouex pipefail

dnf5 install -y \
  "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
  "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

dnf5 swap -y ffmpeg-free ffmpeg --allowerasing
dnf5 install -y \
discord \
gstreamer1-plugins-ugly \
gstreamer1-libav \
vlc
