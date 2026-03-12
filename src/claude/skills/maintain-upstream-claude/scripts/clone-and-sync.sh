#!/bin/bash

# Clone upstream repository using git only, then sync files using rsync
# Usage: clone-and-sync.sh REPO BRANCH DEST_DIR SOURCE_PATH TARGET_PATH
# REPO: Repository identifier (e.g., owner/repo)
# BRANCH: Branch to clone
# DEST_DIR: Destination directory for clone
# SOURCE_PATH: Path in clone to sync from (e.g., "src/claude/")
# TARGET_PATH: Target path to sync to (e.g., ".claude/")

set -e

REPO="$1"
BRANCH="$2"
DEST_DIR="$3"
SOURCE_PATH="$4"
TARGET_PATH="$5"

if [[ -z "$REPO" || -z "$BRANCH" || -z "$DEST_DIR" || -z "$SOURCE_PATH" || -z "$TARGET_PATH" ]]; then
  echo "Usage: clone-and-sync.sh REPO BRANCH DEST_DIR SOURCE_PATH TARGET_PATH" >&2
  exit 1
fi

# Step 1: Prepare workspace
mkdir -p "$(dirname "$DEST_DIR")"
rm -rf "$DEST_DIR"

# Step 2: Clone upstream using git
if ! git clone "https://github.com/${REPO}.git" "$DEST_DIR" --branch "$BRANCH" --single-branch; then
  rm -rf "$DEST_DIR"
  echo "Error: git clone failed" >&2
  exit 1
fi

# Step 3: Sync files with rsync (no --delete to preserve local-only files)
if ! rsync -av "${DEST_DIR}/${SOURCE_PATH}" "$TARGET_PATH"; then
  rm -rf "$DEST_DIR"
  echo "Error: rsync failed" >&2
  exit 1
fi

# Step 4: Clean up
rm -rf "$DEST_DIR"
rmdir --ignore-fail-on-non-empty .tmp 2>/dev/null || true

echo "Success: Clone and sync completed" >&2
exit 0
