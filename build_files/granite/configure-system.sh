#!/bin/bash
set -ouex pipefail

### Enable system services
systemctl enable podman.socket

### Force Konsole dark mode for all users
mkdir -p /etc/skel/.config
cat > /etc/skel/.config/konsolerc << 'EOF'
[UiSettings]
ColorScheme=BreezeDark
EOF

### Disable SELinux and Spectre mitigations for performance
mkdir -p /usr/lib/bootc/kargs.d
cat > /usr/lib/bootc/kargs.d/10-performance.toml << 'EOF'
kargs = ["selinux=0", "mitigations=off"]
EOF
