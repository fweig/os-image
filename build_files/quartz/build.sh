#!/bin/bash
set -ouex pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
common_dir="$(dirname -- "${script_dir}")/common"

"${common_dir}/prepare.sh"
"${script_dir}/remove-packages.sh"
"${script_dir}/install-gnome-apps.sh"
"${common_dir}/install-workstation.sh"
"${common_dir}/install-firefox-beta.sh"
"${common_dir}/install-brave-origin.sh"
"${common_dir}/install-multimedia.sh"
"${common_dir}/install-steam.sh"
"${common_dir}/install-developer-tools.sh"
"${common_dir}/configure-flatpak.sh"
"${common_dir}/configure-system.sh"
"${script_dir}/configure-gnome.sh"
"${common_dir}/verify.sh"
"${script_dir}/verify-gnome.sh"
