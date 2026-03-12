#!/bin/bash

# Categorize files into upstream-modified and local-only sets
# Usage: categorize-files.sh LOCAL_PATH UPSTREAM_PATH
# LOCAL_PATH: Path to local files (e.g., ".claude/")
# UPSTREAM_PATH: Path to upstream files (e.g., ".tmp/ai-devops-maintain/src/claude/")
# Outputs: newline-separated categorized file paths in format:
#   upstream-modified|RELATIVE_PATH
#   local-only|RELATIVE_PATH

set -e

LOCAL_PATH="${1:-.claude}"
UPSTREAM_PATH="$2"

if [[ -z "$UPSTREAM_PATH" ]]; then
  echo "Usage: categorize-files.sh LOCAL_PATH UPSTREAM_PATH" >&2
  exit 1
fi

# Find local files and strip prefix
local_files=$(find "$LOCAL_PATH" -type f | sed "s|^${LOCAL_PATH}/||" | sort)

# Find upstream files and strip prefix
if [[ -d "$UPSTREAM_PATH" ]]; then
  upstream_files=$(find "$UPSTREAM_PATH" -type f | sed "s|^${UPSTREAM_PATH}/||" | sort)
else
  upstream_files=""
fi

# Create associative arrays
declare -A upstream_set
while read -r file; do
  [[ -n "$file" ]] && upstream_set["$file"]=1
done <<< "$upstream_files"

# Categorize files
while read -r file; do
  if [[ -n "$file" ]]; then
    if [[ -n "${upstream_set[$file]}" ]]; then
      echo "upstream-modified|$file"
    else
      echo "local-only|$file"
    fi
  fi
done <<< "$local_files"

exit 0
