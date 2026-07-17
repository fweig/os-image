#!/bin/bash
set -ouex pipefail

rpm -q \
	gnome-shell \
	gnome-session \
	gnome-session-wayland-session
