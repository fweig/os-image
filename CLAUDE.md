# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Feldspar is a bootc container-based OS image project derived from Universal Blue. It produces two images:
- **Feldspar** — Gaming image (Fedora-based, via `Containerfile.feldspar`)
- **Feldspar Granite** — Stable image (AlmaLinux-based, via `Containerfile.granite`)

## Build Commands

All commands use `just` (task runner). Run `just` with no arguments to see available recipes.

```bash
# Build container images
just build                    # Build Feldspar (gaming)
just build-granite            # Build Feldspar Granite (stable)

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
1. `Containerfile.feldspar` / `Containerfile.granite` define image builds from their respective base images
2. `build_files/build-gaming.sh` / `build_files/build-stable.sh` are mounted and executed during build
3. `bootc container lint` validates the final image
4. Disk images (QCOW2/ISO/raw) are generated using Bootc Image Builder (BIB)

**Key files:**
- `Containerfile.feldspar` - Gaming image build (Fedora/Kinoite-based)
- `Containerfile.granite` - Stable image build (AlmaLinux-based)
- `build_files/build-gaming.sh` - Gaming customization script
- `build_files/build-stable.sh` - Stable customization script
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
