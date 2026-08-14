#!/bin/bash
set -ouex pipefail

rpm -q \
	brave-origin \
	btop \
	code \
	firefox-beta \
	flatpak \
	nextcloud-client \
	steam \
	thunderbird \
	vlc \
	xlsclients

if rpm -q htop; then
	echo "htop must not be installed" >&2
	exit 1
fi

systemctl is-enabled btrfs-compress-default.service
systemctl is-enabled podman.socket
