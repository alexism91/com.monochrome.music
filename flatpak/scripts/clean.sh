#!/bin/bash
# Clean build artifacts

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "🧹 Cleaning build artifacts..."

# Remove build directory
if [ -d "$PROJECT_ROOT/build" ]; then
    rm -rf "$PROJECT_ROOT/build"
    echo "   Removed build directory"
fi

# Remove flatpak-builder cache
if [ -d "$PROJECT_ROOT/.flatpak-builder/build" ]; then
    rm -rf "$PROJECT_ROOT/.flatpak-builder/build"
    echo "   Removed flatpak-builder cache"
fi

# Remove repo directory
if [ -d "$PROJECT_ROOT/repo" ]; then
    rm -rf "$PROJECT_ROOT/repo"
    echo "   Removed repo directory"
fi

echo "✅ Clean complete!"
