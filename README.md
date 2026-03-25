# os-image

Custom bootc container-based OS images built on [Universal Blue](https://universal-blue.org/). These are immutable, container-native Linux desktop images deployed as OCI containers.

## Editions

### Gaming (Fedora)

Based on `ghcr.io/ublue-os/kinoite-main:latest`. A KDE Plasma desktop with gaming and multimedia focus.

- Firefox Beta (Mozilla RPM repo), Thunderbird, Nextcloud client
- Steam, Discord, VLC, FFmpeg, GStreamer codecs (via RPMFusion)
- Latest stable Mesa (via Terra)
- KDE Rounded Corners effect
- SELinux disabled, Spectre mitigations off for performance
- Podman socket enabled

### Stable (AlmaLinux)

Based on `quay.io/almalinuxorg/atomic-desktop-kde:10`. A KDE Plasma desktop for reliability.

- Firefox (Mozilla RPM repo), Thunderbird
- VLC, FFmpeg, GStreamer codecs (via RPMFusion)
- SELinux disabled, Spectre mitigations off for performance
- Podman socket enabled

Both editions remove KDE bloat (Akonadi, KDE Connect, Kate, Kwrite, Krfb, etc.) and VM/network packages (open-vm-tools, realmd, Samba, spice-vdagent).


## Switching to this image

From any bootc-based system:

```bash
# Gaming edition
sudo bootc switch ghcr.io/fweig/os-image:gaming

# Stable edition
sudo bootc switch ghcr.io/fweig/os-image:stable
```

## Usage

Requires [just](https://just.systems/), [Podman](https://podman.io/), and optionally `shellcheck`/`shfmt` for linting.

```bash
just                          # List all available recipes

# Build container images
just build                    # Gaming edition (Fedora)
just build-stable             # Stable edition (AlmaLinux)

# Build bootable disk images (requires sudo)
just build-qcow2              # QCOW2 VM image
just build-raw                # Raw disk image
just build-iso                # ISO installer

# Run a VM from a built image
just run-vm-qcow2             # Uses qemux/qemu, opens browser at localhost:8006
just spawn-vm                 # Uses systemd-vmspawn

# Lint and format
just lint                     # shellcheck on all .sh files
just format                   # shfmt on all .sh files

# Clean build artifacts
just clean
```

## CI/CD

GitHub Actions builds and publishes both editions daily to GHCR with Cosign signing. Disk image builds with optional S3 upload are available via a separate workflow.

## Project structure

| Path | Description |
|---|---|
| `Containerfile.gaming` | Gaming edition image definition (Fedora/Kinoite) |
| `Containerfile.stable` | Stable edition image definition (AlmaLinux) |
| `build_files/build-gaming.sh` | Gaming edition packages and customizations |
| `build_files/build-stable.sh` | Stable edition packages and customizations |
| `Justfile` | All build/run/lint commands |
| `disk_config/` | Disk and ISO configuration for Bootc Image Builder |
| `.github/workflows/build.yml` | Container image CI (build + publish + sign) |
| `.github/workflows/build-disk.yml` | Disk image CI with optional S3 upload |
