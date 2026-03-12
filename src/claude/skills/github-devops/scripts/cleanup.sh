#!/bin/bash
# Clean up temporary files created by github-devops skill
# Usage: cleanup.sh
# Removes .tmp/github-devops directory and attempts to remove .tmp if empty

set -e

if [[ -d ".tmp/github-devops" ]]; then
  rm -rf ".tmp/github-devops"
fi

# Remove .tmp directory if empty
rmdir --ignore-fail-on-empty .tmp 2>/dev/null || true

exit 0
