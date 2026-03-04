# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a bootc container-based OS image template derived from Universal Blue. It builds customized, immutable Linux operating system images that are container-native and deployable via OCI/Podman.

## Build Commands

All commands use `just` (task runner). Run `just` with no arguments to see available recipes.

```bash
# Build container image
just build                    # Build with default name/tag
just build aurora lts         # Build with custom name and tag

# Build bootable disk images (requires sudo, uses Bootc Image Builder)
just build-qcow2             # Build QCOW2 VM image
just build-raw               # Build raw disk image
just build-iso               # Build ISO installer

# Rebuild (fresh container build + disk image)
just rebuild-qcow2

# Run VM from built image
just run-vm-qcow2            # Uses qemux/qemu container, opens browser at localhost:8006
just spawn-vm                # Uses systemd-vmspawn

# Linting and formatting
just lint                    # Run shellcheck on all .sh files
just format                  # Run shfmt on all .sh files
just check                   # Check Justfile syntax
just fix                     # Fix Justfile syntax

# Cleanup
just clean                   # Remove build artifacts (_build*, output/)
```

## Architecture

**Build flow:**
1. `Containerfile` defines the image build starting from a base image (default: `ghcr.io/ublue-os/bazzite:stable`)
2. `build_files/build.sh` is mounted and executed during build - this is where packages are installed and customizations are made
3. `bootc container lint` validates the final image
4. Disk images (QCOW2/ISO/raw) are generated using Bootc Image Builder (BIB)

**Key files:**
- `Containerfile` - Image build definition, change `FROM` line to switch base images
- `build_files/build.sh` - Main customization script (package installation, systemctl enables)
- `Justfile` - All build/run commands, configurable via `image_name`, `default_tag`, `bib_image` variables
- `disk_config/disk.toml` - QCOW2/raw disk configuration (20 GiB Btrfs root)
- `disk_config/iso-*.toml` - ISO installer configurations with Anaconda kickstart

**CI/CD (GitHub Actions):**
- `.github/workflows/build.yml` - Builds and publishes container image to GHCR with Cosign signing
- `.github/workflows/build-disk.yml` - Builds disk images with optional S3 upload

## Important Notes

- Container signing is required - CI builds fail without `SIGNING_SECRET` configured
- Never commit `cosign.key` (private signing key)
- Build artifacts go to `output/` directory
- Rootful podman is required for disk image builds (handled automatically by Justfile)
