#!/bin/bash

# Sync files using rsync
# Usage: sync-files.sh SOURCE DEST [--relative]
# SOURCE: Source directory or file with optional ./prefix for --relative
# DEST: Destination directory
# --relative: Use rsync --relative flag for preserving relative paths

set -e

if [[ $# -lt 2 ]]; then
  echo "Usage: sync-files.sh SOURCE DEST [--relative]" >&2
  exit 1
fi

SOURCE="$1"
DEST="$2"
RELATIVE="${3:-}"

if [[ "$RELATIVE" == "--relative" ]]; then
  rsync -av --relative "$SOURCE" "$DEST"
else
  rsync -av "$SOURCE" "$DEST"
fi

exit 0
