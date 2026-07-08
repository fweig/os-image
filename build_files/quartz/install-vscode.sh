#!/bin/bash
set -ouex pipefail

rpm --import https://packages.microsoft.com/keys/microsoft.asc

tee /etc/yum.repos.d/vscode.repo > /dev/null <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
autorefresh=1
type=rpm-md
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

dnf5 makecache --refresh
dnf5 --setopt=install_weak_deps=False install -y \
	code \
	socat \
	python3-pip


# codex
CODEX_VERSION="${CODEX_VERSION:-0.143.0}"
CODEX_PREFIX="${CODEX_PREFIX:-/usr/lib/codex}"
CODEX_BIN="${CODEX_BIN:-/usr/bin/codex}"

dnf5 install -y \
  curl \
  ca-certificates \
  tar \
  gzip \
  bubblewrap

case "$(uname -m)" in
  x86_64)
    CODEX_TARGET="x86_64-unknown-linux-musl"
    ;;
  aarch64|arm64)
    CODEX_TARGET="aarch64-unknown-linux-musl"
    ;;
  *)
    echo "Unsupported architecture: $(uname -m)" >&2
    exit 1
    ;;
esac

ASSET="codex-${CODEX_TARGET}.tar.gz"

if [ "$CODEX_VERSION" = "latest" ]; then
  DOWNLOAD_BASE="https://github.com/openai/codex/releases/latest/download"
else
  DOWNLOAD_BASE="https://github.com/openai/codex/releases/download/rust-v${CODEX_VERSION}"
fi

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

curl -fL \
  --retry 5 \
  --retry-delay 2 \
  --retry-all-errors \
  -o "$TMPDIR/$ASSET" \
  "$DOWNLOAD_BASE/$ASSET"

mkdir -p "$TMPDIR/extract"
tar -xzf "$TMPDIR/$ASSET" -C "$TMPDIR/extract"

CODEX_EXTRACTED_BIN="$(
  find "$TMPDIR/extract" \
    -type f \
    \( -name "codex-${CODEX_TARGET}" -o -name "codex" \) \
    -executable \
    -print \
    -quit
)"

if [ -z "$CODEX_EXTRACTED_BIN" ]; then
  echo "Could not find extracted Codex binary" >&2
  find "$TMPDIR/extract" -maxdepth 3 -type f -print >&2
  exit 1
fi

mkdir -p "$CODEX_PREFIX/bin" "$(dirname "$CODEX_BIN")"

install -m 0755 "$CODEX_EXTRACTED_BIN" "$CODEX_PREFIX/bin/codex"
ln -sf "$CODEX_PREFIX/bin/codex" "$CODEX_BIN"

"$CODEX_BIN" --version
