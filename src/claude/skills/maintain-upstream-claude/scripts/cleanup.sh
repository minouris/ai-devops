#!/bin/bash

# Clean up temporary directory after skill operations
# Usage: cleanup.sh
# Removes .tmp/ai-devops-maintain directory and optionally the .tmp directory itself

set -e

# Remove the cloned repository directory
if [[ -d ".tmp/ai-devops-maintain" ]]; then
  rm -rf ".tmp/ai-devops-maintain"
  echo "Removed .tmp/ai-devops-maintain" >&2
fi

# Remove .tmp directory if empty
rmdir --ignore-fail-on-non-empty .tmp 2>/dev/null || true

echo "Cleanup complete" >&2
exit 0
