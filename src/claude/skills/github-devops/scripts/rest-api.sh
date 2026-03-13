#!/bin/bash
# GitHub REST API Helper
# Wraps curl requests to GitHub REST API with proper authentication and headers
# Usage: rest-api.sh METHOD ENDPOINT [JSON_DATA]
# Outputs: Raw JSON response, or exits with error

set -e

METHOD="$1"
ENDPOINT="$2"
JSON_DATA="$3"

if [[ -z "$METHOD" || -z "$ENDPOINT" ]]; then
  echo "Usage: rest-api.sh METHOD ENDPOINT [JSON_DATA]" >&2
  exit 1
fi

# Get token from github-auth helper
TOKEN=$(${CLAUDE_SKILL_DIR}/scripts/github-auth.sh)

# Build curl command (FINDING-2026-03-11-24 verified REST API pattern)
if [[ -n "$JSON_DATA" ]]; then
  HTTP_RESPONSE=$(curl -s -w '\n%{http_code}' -X "$METHOD" \
    "https://api.github.com$ENDPOINT" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    -H "Content-Type: application/json" \
    -d "$JSON_DATA")
else
  HTTP_RESPONSE=$(curl -s -w '\n%{http_code}' -X "$METHOD" \
    "https://api.github.com$ENDPOINT" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28")
fi

HTTP_STATUS=$(printf '%s\n' "$HTTP_RESPONSE" | tail -n 1)
HTTP_BODY=$(printf '%s\n' "$HTTP_RESPONSE" | sed '$d')

# Output body for callers/debugging
printf '%s\n' "$HTTP_BODY"

# Exit non-zero on non-2xx/3xx HTTP status codes
if [[ "$HTTP_STATUS" -lt 200 || "$HTTP_STATUS" -ge 400 ]]; then
  exit 1
fi
