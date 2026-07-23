#!/bin/bash
set -ouex pipefail

# Remove only applications superseded by the shared workstation selection and
# a small set of preinstalled games. Retain general-purpose Plasma utilities.
dnf5 remove -y \
	dragon \
	htop \
	kaddressbook \
	kmahjongg \
	kmail \
	kmines \
	kontact \
	korganizer \
	kpat \
	plasma-welcome
