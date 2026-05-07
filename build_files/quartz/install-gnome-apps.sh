#!/bin/bash
set -ouex pipefail

dnf5 --setopt=install_weak_deps=False install -y \
	file-roller \
	flatpak \
	gdm \
	glycin-loaders \
	glycin-thumbnailer \
	gnome-disk-utility \
	gnome-shell \
	gnome-software \
	gnome-session \
	gnome-session-wayland-session \
	gnome-text-editor \
	loupe \
	nautilus \
	ptyxis \
	thunderbird # not a gnome app, but flatpak is too old
