#!/bin/bash
set -e

if [[ ! -d "package-sources" ]]; then
  echo "Error: This script must be run from the project root."
  exit 1
fi

ORIG_TAR="package-sources/openssl_1.1.1w.orig.tar.gz"
# DEBIAN_TAR="package-sources/openssl_1.1.1w-0+deb11u3.debian.tar.xz"
DEBIAN_TAR="package-sources/openssl_1.1.1w+volumio1.debian.tar.xz"
DEST_DIR="build/openssl1.1/source"

if [[ ! -f "$ORIG_TAR" ]]; then
  echo "Error: Missing $ORIG_TAR"
  exit 1
fi

if [[ ! -f "$DEBIAN_TAR" ]]; then
  echo "Error: Missing $DEBIAN_TAR"
  exit 1
fi

echo "[+] Cleaning $DEST_DIR"
rm -rf "$DEST_DIR"
mkdir -p "$DEST_DIR"

echo "[+] Extracting OpenSSL source to $DEST_DIR"
tar -xvzf "$ORIG_TAR" -C "$DEST_DIR" --strip-components=1

echo "[+] Extracting debian packaging into $DEST_DIR/debian"
mkdir -p "$DEST_DIR/debian"
tar -xf "$DEBIAN_TAR" -C "$DEST_DIR" --strip-components=1

echo "[✓] OpenSSL sources and debian files are extracted to $DEST_DIR"
