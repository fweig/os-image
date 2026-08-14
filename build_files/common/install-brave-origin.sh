#!/bin/bash
set -ouex pipefail

dnf5 config-manager addrepo \
	--from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
dnf5 --setopt=install_weak_deps=False install -y brave-origin
