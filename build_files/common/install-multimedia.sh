#!/bin/bash
set -ouex pipefail

dnf5 install -y \
	"https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
	"https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

dnf5 swap -y ffmpeg-free ffmpeg --allowerasing
dnf5 --setopt=install_weak_deps=False install -y \
	discord \
	gstreamer1-libav \
	gstreamer1-plugins-ugly \
	vlc
