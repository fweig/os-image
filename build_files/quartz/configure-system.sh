#!/bin/bash
set -ouex pipefail

# Enable Btrfs zstd compression on root and /var. BIB's filesystem
# customizations don't support mount options, so we set the compression
# as a Btrfs property — it lives in the filesystem metadata and applies
# to all new writes regardless of mount options. Idempotent on reboot.
cat > /usr/lib/systemd/system/btrfs-compress-default.service << 'EOF'
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
systemctl enable gdm.service
