#!/bin/bash
set -ouex pipefail

# BIB does not support Btrfs mount options, so store the compression policy in
# filesystem metadata and apply it to new writes on both root subvolumes.
cat > /usr/lib/systemd/system/btrfs-compress-default.service <<'EOF'
[Unit]
Description=Set default Btrfs zstd compression on root subvolumes
ConditionPathExists=/usr/bin/btrfs
RequiresMountsFor=/ /var
After=local-fs.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/btrfs property set / compression zstd
ExecStart=-/usr/bin/btrfs property set /var compression zstd

[Install]
WantedBy=multi-user.target
EOF

systemctl enable btrfs-compress-default.service
systemctl enable podman.socket
