#!/bin/bash
set -ouex pipefail

dnf5 install -y \
	file-roller \
	gnome-disk-utility \
	gnome-text-editor
