#!/bin/bash
set -ouex pipefail

# Keep Quartz deliberately lean by removing inherited services, legacy desktop
# applications, enterprise integration, and virtualization guest tooling.
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
	gnome-terminal \
	gnome-terminal-nautilus \
	gnome-tour \
	gnome-user-docs \
	gnome-user-share \
	htop \
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
