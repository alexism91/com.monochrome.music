#!/bin/bash
# Run Monochrome Flatpak application

set -e

echo "🚀 Launching Monochrome..."
flatpak run com.monochrome.music "$@"
