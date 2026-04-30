#!/bin/bash
set -ouex pipefail

dnf5 install -y \
	file-roller \
	gdm \
	gnome-disk-utility \
	gnome-shell \
	gnome-session \
	gnome-session-wayland-session \
	gnome-text-editor \
	ptyxis
