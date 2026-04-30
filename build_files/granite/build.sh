#!/bin/bash
set -ouex pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

"${script_dir}/remove-packages.sh"
"${script_dir}/install-base.sh"
"${script_dir}/install-firefox.sh"
"${script_dir}/install-multimedia.sh"
"${script_dir}/configure-system.sh"
