# volumio-openssl-1.1

Custom build of OpenSSL 1.1.1w for Debian Bookworm with multi-architecture `.deb` packaging, compatible with Volumio's Bookworm-based platform.

This project exists to reintroduce `libssl1.1` into Bookworm, where OpenSSL 1.1 has been removed upstream. It is required for compatibility with legacy components, plugins, and closed-source binaries in the Volumio ecosystem.

## Features

- Cross-compiled OpenSSL 1.1.1w for:
  - `armv6` (Raspberry Pi Zero, Pi 1)
  - `armhf` (Pi 2, Pi 3 32-bit)
  - `arm64` (Pi 3, Pi 4, Pi 5 64-bit)
  - `amd64` (x86_64 platforms, NUCs)
- Based on Debian Security patchset (`openssl_1.1.1w`)
- Skips tests via `DEB_BUILD_OPTIONS=nocheck` for stable builds in Docker
- Produces `.deb` packages renamed per Volumio naming rules:
  - `_arm.deb` for armv6
  - `_armv7.deb` for armhf
  - `_armv8.deb` for arm64
  - `_x64.deb` for amd64

## Layout

```

.
├── build/                # Extracted and patched sources
├── out/                  # Final output .deb packages by architecture
├── package-sources/      # OpenSSL .orig.tar.gz and patched .debian.tar.xz
├── scripts/              # Automation scripts (extract, clean)
├── docker/               # Architecture-specific Dockerfiles + runner
├── build-matrix.sh       # Top-level build orchestrator
└── README.md             # This file

````

## Usage

### 1. Add source tarballs

Place the following into `package-sources/`:

- `openssl_1.1.1w.orig.tar.gz`
- `openssl_1.1.1w+volumio1.debian.tar.xz`

### 2. Extract, build and rename

Build for all supported architectures:

```bash
./build-matrix.sh --volumio --verbose
````

This will:

* Extract a clean source tree per arch
* Run cross-architecture builds in Docker
* Output `.deb` files into `out/<arch>/`
* Rename files per Volumio conventions

### 3. Clean up

```bash
./scripts/clean-all.sh
```

## Notes

* The OpenSSL test suite is skipped intentionally (`DEB_BUILD_OPTIONS=nocheck`) due to false negatives in cross-compiled or emulated Docker environments.
* The `debian/changelog` has been updated to reflect version `1.1.1w+volumio1`.
* Only packages relevant to Volumio's runtime are built (typically `libssl1.1` and `openssl`).

## License

This project uses upstream Debian sources, which are licensed under the OpenSSL License and/or the original Apache-style license. All build scripts and Dockerfiles are MIT licensed unless otherwise specified.

## Maintainer

This build is maintained for use within the Volumio Bookworm migration stack by community volunteers.
