#!/bin/bash
set -ouex pipefail

dnf5 --setopt=clean_requirements_on_remove=False remove -y gnome-tour

rpm -q \
	gnome-shell \
	gnome-session \
	gnome-session-wayland-session
