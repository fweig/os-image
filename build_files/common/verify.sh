#!/bin/bash
set -ouex pipefail

rpm -q \
	code \
	firefox-beta \
	flatpak \
	nextcloud-client \
	steam \
	thunderbird \
	vlc

systemctl is-enabled btrfs-compress-default.service
systemctl is-enabled podman.socket
