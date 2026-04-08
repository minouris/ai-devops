#!/bin/bash
# GitHub GraphQL API Helper
# Wraps curl requests to GitHub GraphQL API with proper authentication
# Usage: graphql-api.sh GRAPHQL_QUERY
# GRAPHQL_QUERY: GraphQL operation as a string (query or mutation)
# Outputs: Raw JSON response from GraphQL API, or exits with error

set -e

GRAPHQL_QUERY="$1"

if [[ -z "$GRAPHQL_QUERY" ]]; then
  echo "Usage: graphql-api.sh GRAPHQL_QUERY" >&2
  exit 1
fi

# Source centralized sanitization functions
source "${CLAUDE_SKILL_DIR}/scripts/sanitize.sh"

# Get token from github-auth helper
TOKEN=$(${CLAUDE_SKILL_DIR}/scripts/github-auth.sh)

# Safely escape GraphQL query string before embedding in JSON payload
GRAPHQL_QUERY_ESCAPED=$(escape_json_string "$GRAPHQL_QUERY")

# Build JSON payload with escaped query (FINDING-2026-03-11-27 verified GraphQL pattern)
PAYLOAD=$(cat <<EOF
{
  "query": "$GRAPHQL_QUERY_ESCAPED"
}
EOF
)

# Execute GraphQL mutation/query (FINDING-2026-03-11-27 verified pattern)
RESPONSE=$(curl -sSf -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -d "$PAYLOAD") || {
  echo "Error: GitHub GraphQL API request failed" >&2
  exit 1
}

# Check for GraphQL-level errors in the JSON response
if echo "$RESPONSE" | jq -e '.errors and (.errors | length > 0)' >/dev/null 2>&1; then
  echo "Error: GitHub GraphQL API returned errors:" >&2
  echo "$RESPONSE" | jq '.errors' >&2
  exit 1
fi

# No GraphQL errors detected; output raw JSON response
echo "$RESPONSE"
