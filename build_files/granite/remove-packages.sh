#!/bin/bash
set -ouex pipefail

dnf remove -y \
akonadi-server \
akonadi-server-mysql \
firefox \
kate \
kde-connect \
kio-gdrive \
krfb \
krfb-libs \
kwrite \
libkgapi \
libwinpr \
mpage \
open-vm-tools \
plasma-drkonqi \
plasma-welcome \
python3-boto3 \
realmd \
samba \
spice-vdagent
