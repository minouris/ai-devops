#!/bin/bash

# Scan files for sensitive content patterns
# Usage: scan-sensitive.sh FILE [FILE ...]
# Outputs: newline-separated flagged file paths in format:
#   FILEPATH:LINENO:MATCHED_TEXT

set -e

if [[ $# -eq 0 ]]; then
  echo "Usage: scan-sensitive.sh FILE [FILE ...]" >&2
  exit 1
fi

# Pattern from the action file
PATTERN='(password|passwd|api_key|apikey|api[-_]secret|bearer [a-zA-Z0-9]{20,}|BEGIN (RSA |EC |OPENSSH |DSA )?PRIVATE KEY|token\s*[:=]\s*['\''"]?[a-zA-Z0-9_\-]{20,})'

found_any=0

for file in "$@"; do
  if [[ -f "$file" ]]; then
    if grep -niE "$PATTERN" "$file" 2>/dev/null; then
      found_any=1
    fi
  fi
done

exit 0
