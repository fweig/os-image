#!/bin/bash
set -ouex pipefail

dnf5 --setopt=install_weak_deps=False install -y \
	btop \
	flatpak \
	nextcloud-client \
	thunderbird
