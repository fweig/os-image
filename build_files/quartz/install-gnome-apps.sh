#!/bin/bash
set -ouex pipefail

dnf5 --setopt=install_weak_deps=False install -y \
	file-roller \
	flatpak \
	gdm \
	gnome-disk-utility \
	gnome-shell \
	gnome-software \
	gnome-session \
	gnome-session-wayland-session \
	gnome-text-editor \
	nautilus \
	ptyxis
