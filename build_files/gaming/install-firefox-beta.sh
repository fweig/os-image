#!/bin/bash
set -ouex pipefail

dnf5 config-manager addrepo --id=mozilla --set=baseurl=https://packages.mozilla.org/rpm/firefox --set=gpgkey=https://packages.mozilla.org/rpm/firefox/signing-key.gpg --set=repo_gpgcheck=0
dnf5 makecache --refresh
dnf5 install -y firefox-beta
