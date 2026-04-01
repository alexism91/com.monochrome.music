#!/bin/bash
# Build script for Monochrome Flatpak
# This script builds the Flatpak package from source

set -euo pipefail

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Project root is the parent of flatpak/ (go up two levels from scripts/)
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Flatpak sources directory
FLATPAK_SOURCES_DIR="$PROJECT_ROOT/flatpak/sources"

# Build output directory
BUILD_DIR="$PROJECT_ROOT/build"

echo "🔨 Building Monochrome Flatpak..."
echo "   Script dir: $SCRIPT_DIR"
echo "   Project root: $PROJECT_ROOT"
echo "   Flatpak sources: $FLATPAK_SOURCES_DIR"
echo "   Build dir: $BUILD_DIR"

# Check prerequisites
command -v flatpak-builder >/dev/null 2>&1 || { echo "❌ ERROR: flatpak-builder not installed"; exit 1; }
command -v flatpak >/dev/null 2>&1 || { echo "❌ ERROR: flatpak not installed"; exit 1; }

# Verify the manifest exists
if [ ! -f "$FLATPAK_SOURCES_DIR/com.monochrome.music.json" ]; then
    echo "❌ Error: Manifest not found at $FLATPAK_SOURCES_DIR/com.monochrome.music.json"
    exit 1
fi

# Show SDK version for reproducibility
echo "📦 Checking SDK version..."
flatpak info org.freedesktop.Sdk//24.08 2>/dev/null || echo "⚠️  SDK 24.08 not installed (will be downloaded)"

# Clean previous build
if [ -d "$BUILD_DIR" ]; then
    echo "🧹 Cleaning previous build..."
    rm -rf "$BUILD_DIR"
fi

# Clean flatpak-builder cache (optional, comment out to speed up rebuilds)
if [ -d "$PROJECT_ROOT/.flatpak-builder/build" ]; then
    echo "🧹 Cleaning flatpak-builder cache..."
    rm -rf "$PROJECT_ROOT/.flatpak-builder/build"
fi

# Run flatpak-builder (build only, no install)
echo "📦 Building Flatpak package..."
flatpak-builder \
    --force-clean \
    "$BUILD_DIR" \
    "$FLATPAK_SOURCES_DIR/com.monochrome.music.json"

echo ""
echo "✅ Build complete!"
echo ""
echo "Build artifacts are in: $BUILD_DIR"
echo ""
echo "To create a bundle file:"
echo "   flatpak build-bundle $BUILD_DIR com.monochrome.music.flatpak com.monochrome.music"
echo ""
echo "To install and run:"
echo "   flatpak install --user $BUILD_DIR/com.monochrome.music.flatpak"
echo "   flatpak run com.monochrome.music"
echo ""
