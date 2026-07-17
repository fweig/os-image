#!/bin/bash
set -ouex pipefail

dnf5 config-manager addrepo \
	--id=mozilla \
	--set=baseurl=https://packages.mozilla.org/rpm/firefox \
	--set=gpgcheck=1 \
	--set=gpgkey=https://packages.mozilla.org/rpm/firefox/signing-key.gpg \
	--set=repo_gpgcheck=0
dnf5 makecache --refresh
dnf5 remove -y firefox firefox-langpacks
dnf5 --setopt=install_weak_deps=False install -y firefox-beta
