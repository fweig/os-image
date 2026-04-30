#!/bin/bash
set -ouex pipefail

# Future minimization candidates (kept for now):
#
# Printing/scanning stack — cups, cups-filters, gutenprint, hplip,
# printer-driver-brlaser, sane-* (~400 MiB combined).
#   Tradeoff: no out-of-the-box printing/scanning. Users would need to layer
#   it back in (awkward on bootc) or rely on Flatpak alternatives where they
#   exist. Aeon ships without these.
#
# google-noto-* fonts (57 packages, hundreds of MiB).
#   Tradeoff: text rendering breaks for non-Latin scripts (CJK, Arabic,
#   Hebrew, Thai, Indic, etc). If pursuing this, keep at least:
#     google-noto-fonts-common, google-noto-sans-cjk-fonts,
#     google-noto-color-emoji-fonts, google-noto-sans-mono-vf-fonts
#   to preserve emoji + monospace + CJK fallback.

dnf5 remove -y \
	buildah \
	cifs-utils \
	cifs-utils-info \
	cldr-emoji-annotation \
	fedora-bookmarks \
	fedora-logos-httpd \
	freerdp-libs \
	geolite2-city \
	gnome-color-manager \
	gnome-remote-desktop \
	gnome-shell-extension-apps-menu \
	gnome-shell-extension-background-logo \
	gnome-shell-extension-launch-new-instance \
	gnome-shell-extension-places-menu \
	gnome-shell-extension-window-list \
	gnome-tour \
	gnome-user-docs \
	gnome-user-share \
	libwinpr \
	malcontent \
	malcontent-control \
	malcontent-libs \
	malcontent-ui-libs \
	open-vm-tools \
	python3-boto3 \
	python3-botocore \
	qemu-user-static-aarch64 \
	realmd \
	samba-client \
	samba-client-libs \
	samba-common \
	samba-common-libs \
	sssd-client \
	sssd-common \
	sssd-kcm \
	sssd-krb5-common \
	sssd-nfs-idmap \
	toolbox \
	virtualbox-guest-additions \
	yelp \
	yelp-libs \
	yelp-xsl
