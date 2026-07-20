#!/bin/bash
set -ouex pipefail

dnf5 --setopt=install_weak_deps=False install -y \
	gwenview \
	kcalc \
	okular \
	skanpage \
	https://zoom.us/client/latest/zoom_x86_64.rpm
