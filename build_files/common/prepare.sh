#!/bin/bash
set -ouex pipefail

# bootc images expect /opt to be a real, writable directory at runtime.
if [[ -L /opt ]]; then
	rm /opt
fi
mkdir -p /opt
