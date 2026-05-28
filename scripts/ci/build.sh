#!/usr/bin/env bash
# Build one or all service images.
# Usage: ./build.sh [service] [version]
#   service  — tag_suffix of service to build, or "all" (default: all)
#   version  — image version tag (default: dev)
set -euo pipefail

SERVICE="${1:-all}"
VERSION="${2:-dev}"

export IMAGE_VERSION="$VERSION"

if [ "$SERVICE" = "all" ]; then
  echo "--- Building all images (version=$VERSION) ---"
  make build
else
  echo "--- Building $SERVICE (version=$VERSION) ---"
  make "build-$SERVICE"
fi
