#!/bin/bash
set -ouex pipefail

if command -v flatpak > /dev/null; then
	flatpak --system uninstall --noninteractive -y --all || true
	flatpak --system remote-delete --force fedora || true
	flatpak --system remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

mkdir -p /usr/lib/environment.d

cat > /usr/lib/environment.d/60-flatpak.conf <<'EOF'
XDG_DATA_DIRS=%h/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}
EOF

rm -f \
	/etc/flatpak/remotes.d/fedora.flatpakrepo \
	/usr/etc/flatpak/remotes.d/fedora.flatpakrepo \
	/usr/share/flatpak/remotes.d/fedora.flatpakrepo

rm -rf \
	/usr/share/ublue-os/firstboot/flatpaks \
	/usr/share/ublue-os/flatpaks
