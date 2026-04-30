#!/bin/bash
set -ouex pipefail

if command -v flatpak > /dev/null; then
	flatpak --system uninstall --noninteractive -y --all || true
	flatpak --system remote-delete --force fedora || true
	flatpak --system remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

rm -f \
	/etc/flatpak/remotes.d/fedora.flatpakrepo \
	/usr/etc/flatpak/remotes.d/fedora.flatpakrepo \
	/usr/share/flatpak/remotes.d/fedora.flatpakrepo

rm -rf \
	/usr/share/ublue-os/firstboot/flatpaks \
	/usr/share/ublue-os/flatpaks
