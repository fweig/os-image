#!/bin/bash
set -ouex pipefail

rm /opt
mkdir /opt

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

"${script_dir}/remove-packages.sh"
"${script_dir}/install-firefox-beta.sh"
"${script_dir}/install-vscode.sh"
"${script_dir}/configure-system.sh"
