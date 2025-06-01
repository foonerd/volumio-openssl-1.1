#!/bin/bash
set -e

echo "[*] Cleaning build directories..."
rm -rf build/openssl1.1

echo "[*] Cleaning output .deb packages..."
rm -rf out/*

echo "[*] Cleaning any stray build products..."
find build/ -type f \( -name "*.deb" -o -name "*.build" -o -name "*.changes" -o -name "*.dsc" -o -name "*.tar.*" \) -exec rm -f {} +

echo "[✓] Clean complete."
