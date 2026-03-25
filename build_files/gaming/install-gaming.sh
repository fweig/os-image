#!/bin/bash
set -ouex pipefail

# Steam
dnf5 install -y steam

# Latest stable Mesa from Terra
dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release-mesa
dnf5 -y swap --from-repo=terra-mesa mesa-filesystem mesa-filesystem
dnf5 -y config-manager setopt "*fedora*".exclude="mesa-*"
