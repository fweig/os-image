#!/bin/bash
set -ouex pipefail

dnf5 --setopt=install_weak_deps=False install -y \
	flatpak \
	nextcloud-client \
	thunderbird
