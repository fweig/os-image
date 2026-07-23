#!/bin/bash
set -ouex pipefail

rpm -q btop

if rpm -q htop; then
	echo "htop must not be installed" >&2
	exit 1
fi
