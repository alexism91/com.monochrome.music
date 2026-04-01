#!/bin/bash
# Export Flatpak to a bundle file for distribution

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
FLATPAK_DIR="$PROJECT_ROOT/flatpak"
BUILD_DIR="$PROJECT_ROOT/build"
REPO_DIR="$PROJECT_ROOT/repo"

echo "📦 Exporting Flatpak bundle..."

# Create repo from build
echo "   Creating repository..."
flatpak-builder --repo="$REPO_DIR" "$BUILD_DIR" "$FLATPAK_DIR/sources/com.monochrome.music.json"

# Build bundle
echo "   Creating bundle file..."
flatpak build-bundle "$REPO_DIR" "$PROJECT_ROOT/com.monochrome.music.flatpak" com.monochrome.music

echo ""
echo "✅ Bundle created: $PROJECT_ROOT/com.monochrome.music.flatpak"
echo ""
echo "To install from bundle:"
echo "   flatpak install com.monochrome.music.flatpak"
echo ""
