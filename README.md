# Feldspar

Custom bootc container-based OS images built on [Universal Blue](https://universal-blue.org/). These are immutable, container-native Linux desktop images deployed as OCI containers.

## Editions

### Feldspar (Plasma)

Based on `ghcr.io/ublue-os/kinoite-main:latest`. A general-purpose KDE Plasma workstation.

- Firefox Beta, Thunderbird, Nextcloud client, and Visual Studio Code
- Steam, Discord, VLC, FFmpeg, and GStreamer codecs via RPM Fusion
- npm, pip, and common development and document-tooling dependencies
- Flathub enabled with Fedora Flatpaks removed
- Btrfs zstd compression and the Podman socket enabled
- KDE Rounded Corners effect

### Feldspar Granite (Stable)

Based on `quay.io/almalinuxorg/atomic-desktop-kde:10`. A KDE Plasma desktop for reliability.

- Firefox (Mozilla RPM repo), Thunderbird
- VLC, FFmpeg, GStreamer codecs (via RPMFusion)
- SELinux disabled, Spectre mitigations off for performance
- Podman socket enabled

Granite retains its own package and system policy.

### Feldspar Quartz (GNOME)

Based on `ghcr.io/ublue-os/silverblue-main:latest`. A general-purpose GNOME workstation with the same shared software and system policy as Feldspar.

- Firefox Beta, Thunderbird, Nextcloud client, and Visual Studio Code
- Steam, Discord, VLC, FFmpeg, and GStreamer codecs via RPM Fusion
- npm, pip, and common development and document-tooling dependencies
- Ptyxis, GNOME Files, GNOME Software, GNOME Text Editor, File Roller, and GNOME Disks
- Flathub enabled with Fedora Flatpaks removed
- Btrfs zstd compression and the Podman socket enabled
- Removes inherited remote access, enterprise integration, guest tooling, documentation, and legacy GNOME components

## Switching to this image

From any bootc-based system:

```bash
# Feldspar (Plasma)
sudo bootc switch ghcr.io/fweig/feldspar:latest

# Feldspar Granite (Stable)
sudo bootc switch ghcr.io/fweig/feldspar-granite:latest

# Feldspar Quartz (GNOME)
sudo bootc switch ghcr.io/fweig/feldspar-quartz:latest
```

## Usage

Requires [just](https://just.systems/), [Podman](https://podman.io/), and optionally `shellcheck`/`shfmt` for linting.

```bash
just                          # List all available recipes

# Build container images
just build                    # Feldspar (Plasma)
just build-granite            # Feldspar Granite (Stable)
just build-quartz             # Feldspar Quartz (GNOME)

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
| `Containerfile.feldspar` | Feldspar image definition (Fedora/Kinoite) |
| `Containerfile.granite` | Feldspar Granite image definition (AlmaLinux) |
| `Containerfile.quartz` | Feldspar Quartz image definition (Fedora/Silverblue) |
| `build_files/common/` | Shared workstation scripts for Feldspar and Quartz |
| `build_files/feldspar/` | Feldspar Plasma-specific scripts |
| `build_files/granite/` | Stable edition scripts |
| `build_files/quartz/` | Quartz GNOME-specific scripts |
| `Justfile` | All build/run/lint commands |
| `disk_config/` | Disk and ISO configuration for Bootc Image Builder |
| `.github/workflows/build.yml` | Container image CI (build + publish + sign) |
| `.github/workflows/build-disk.yml` | Disk image CI with optional S3 upload |
