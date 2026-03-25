#!/bin/bash
set -ouex pipefail

### Enable system services
systemctl enable podman.socket

### KDE Rounded Corners effect
dnf5 -y copr enable matinlotfali/KDE-Rounded-Corners
dnf5 install -y kwin-effect-roundcorners
dnf5 -y copr disable matinlotfali/KDE-Rounded-Corners

# Disable native window outline to prevent overlap with rounded corners effect
# Set corner radius to 8 for rounded corners effect
mkdir -p /etc/skel/.config
cat >> /etc/skel/.config/breezerc << 'EOF'
[Common]
OutlineIntensity=OutlineOff
EOF
cat >> /etc/skel/.config/kwinrc << 'EOF'
[Round-Corners]
Size=8
InactiveCornerRadius=8
EOF

### Force Konsole dark mode for all users
cat > /etc/skel/.config/konsolerc << 'EOF'
[UiSettings]
ColorScheme=BreezeDark
EOF

### Disable SELinux and Spectre mitigations for performance
mkdir -p /usr/lib/bootc/kargs.d
cat > /usr/lib/bootc/kargs.d/10-performance.toml << 'EOF'
kargs = ["selinux=0", "mitigations=off"]
EOF
