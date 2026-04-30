# Agent Guide

Guidance for AI coding agents working in this repository.

## Project Overview

Feldspar is a bootc container-based OS image project derived from Universal Blue.
It produces three published images:

- **Feldspar** — Gaming image (Fedora/Kinoite-based, via `Containerfile.feldspar`)
- **Feldspar Granite** — Stable image (AlmaLinux-based, via `Containerfile.granite`)
- **Feldspar Quartz** — Minimal GNOME image (Fedora/Silverblue-based, via `Containerfile.quartz`)

## Build Commands

All commands use `just` (task runner). Run `just` with no arguments to see available recipes.

```bash
# Build container images
just build                    # Build Feldspar (gaming)
just build-granite            # Build Feldspar Granite (stable)
just build-quartz             # Build Feldspar Quartz (minimal GNOME)

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

Disk image and VM recipes may need rootful Podman or sudo. Do not run expensive image builds unless the task specifically calls for them.

## Architecture

**Build flow:**

1. `Containerfile.feldspar` / `Containerfile.granite` / `Containerfile.quartz` define image builds from their respective base images
2. Each Containerfile bind-mounts its matching `build_files/<edition>/` directory and runs its `build.sh` entrypoint in a single modification layer
3. `bootc container lint` validates the final image
4. CI rechunks the built image before publishing so client upgrades can reuse unchanged per-package layers
5. Disk images (QCOW2/ISO/raw) are generated using Bootc Image Builder (BIB)

**Key files:**

- `Containerfile.feldspar` - Gaming image build (Fedora/Kinoite-based)
- `Containerfile.granite` - Stable image build (AlmaLinux-based)
- `Containerfile.quartz` - Minimal GNOME image build (Fedora/Silverblue-based)
- `build_files/gaming/` - Modular scripts and `build.sh` entrypoint for the Gaming image
- `build_files/granite/` - Modular scripts and `build.sh` entrypoint for the Stable image
- `build_files/quartz/` - Modular scripts and `build.sh` entrypoint for the Minimal GNOME image
- `Justfile` - All build/run commands, configurable via `image_name`, `default_tag`, `bib_image` variables
- `disk_config/disk.toml` - QCOW2/raw disk configuration (20 GiB Btrfs root)
- `disk_config/iso-*.toml` - ISO installer configurations with Anaconda kickstart

**CI/CD (GitHub Actions):**

- `.github/workflows/build.yml` - Builds, rechunks, publishes, and signs container images on GHCR
- `.github/workflows/build-disk.yml` - Builds disk images with optional S3 upload

## Editing Notes

- Keep edition-specific changes inside the relevant `build_files/<edition>/` directory when possible
- Keep each edition's `build.sh` as a simple ordered orchestrator; put actual package/configuration logic in the smaller scripts it calls
- Preserve script executable bits when adding new shell entrypoints
- Prefer `just check`, `bash -n`, `shellcheck`, and `shfmt` for quick validation when available
- Container signing is required - CI builds fail without `SIGNING_SECRET` configured
- Never commit `cosign.key` (private signing key)
- Build artifacts go to `output/` directory
- Rootful podman is required for disk image builds (handled automatically by Justfile)
