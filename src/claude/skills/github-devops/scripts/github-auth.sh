#!/bin/bash
# GitHub Authentication Helper
# Extracts and validates GitHub token from git credential helper
# Usage: github-auth.sh
# Outputs: GITHUB_TOKEN environment variable, or exits with error

set -e

# Retrieve credentials from git credential system (FINDING-2026-03-11-23 verified pattern)
CREDS=$(echo "protocol=https
host=github.com
" | GIT_TERMINAL_PROMPT=0 git credential fill)

# Parse token from output (FINDING-2026-03-11-23 verified parsing pattern)
TOKEN=$(echo "$CREDS" | grep "^password=" | cut -d= -f2)

if [[ -z "$TOKEN" ]]; then
  echo "Error: Failed to retrieve GitHub token from credential helper" >&2
  exit 1
fi

# Export token for use by calling process
echo "$TOKEN"
