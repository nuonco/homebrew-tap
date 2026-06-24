#!/bin/bash
# shellcheck disable=SC2250,SC2312
#
# Build Homebrew bottles for the nuon formula by repackaging the prebuilt
# binaries from S3. Bottles let `brew install` pour a tarball directly
# instead of running the sandboxed build phase.
#
# Usage: ./scripts/bottle.sh <version> [output-dir]
#
# Writes per-platform tarballs named `nuon-<version>.<tag>.bottle.tar.gz`
# (the exact filename Homebrew requests under the formula's root_url) and a
# `shas.env` file consumed by generate.sh.

set -euo pipefail

version=$1
outdir=${2:-bottles}

cli_artifact_url="https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/$version"
lsp_artifact_url="https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/$version"

cli_checksum_file=$(curl -fsS "$cli_artifact_url/checksums.txt")
lsp_checksum_file=$(curl -fsS "$lsp_artifact_url/checksums.txt" || true)
if echo "$lsp_checksum_file" | grep -q "nuon-lsp"; then
  has_lsp=true
else
  has_lsp=false
fi

sha256_of() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | cut -d' ' -f1
  else
    shasum -a 256 "$1" | cut -d' ' -f1
  fi
}

# Download $1 to $2 and verify it against the sha listed in $3 (checksums.txt content).
fetch_verified() {
  local url=$1 dest=$2 checksums=$3
  local file expected actual
  file=$(basename "$url")
  curl -fsSL "$url" -o "$dest"
  expected=$(echo "$checksums" | grep "${file}$" | cut -b -64)
  actual=$(sha256_of "$dest")
  if [ -z "$expected" ] || [ "$expected" != "$actual" ]; then
    echo "checksum mismatch for $file: expected '$expected', got '$actual'" >&2
    exit 1
  fi
}

mkdir -p "$outdir"
shas_file="$outdir/shas.env"
: >"$shas_file"

workdir=$(mktemp -d)
trap 'rm -rf "$workdir"' EXIT

# bottle tag -> artifact platform suffix
#
# Homebrew pours a bottle tagged for an older macOS on any newer macOS with
# the same architecture, so tagging with big_sur (macOS 11, the oldest
# version Homebrew still recognises) covers every mac user. Linux tags are
# distro-independent. 32-bit ARM Linux has no bottle tag; those users keep
# building from source.
bottle_platforms="
arm64_big_sur darwin_arm64
big_sur darwin_amd64
x86_64_linux linux_amd64
arm64_linux linux_arm64
"

echo "$bottle_platforms" | while read -r tag platform; do
  [ -z "$tag" ] && continue

  keg="$workdir/$tag/nuon/$version"
  mkdir -p "$keg/bin"

  fetch_verified "$cli_artifact_url/nuon_$platform" "$keg/bin/nuon" "$cli_checksum_file"
  chmod 0555 "$keg/bin/nuon"

  if [ "$has_lsp" = true ]; then
    fetch_verified "$lsp_artifact_url/nuon-lsp_$platform" "$keg/bin/nuon-lsp" "$lsp_checksum_file"
    chmod 0555 "$keg/bin/nuon-lsp"
  fi

  tarball="$outdir/nuon-$version.$tag.bottle.tar.gz"
  tar -czf "$tarball" -C "$workdir/$tag" nuon
  echo "BOTTLE_SHA_$tag=$(sha256_of "$tarball")" >>"$shas_file"
  echo "✅ built $tarball"
done

cat "$shas_file"
