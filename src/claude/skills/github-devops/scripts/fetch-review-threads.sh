#!/bin/bash
# Fetch review threads for a Pull Request via GitHub GraphQL API
# Usage: fetch-review-threads.sh OWNER REPO PR_NUMBER
# OWNER: Repository owner
# REPO: Repository name
# PR_NUMBER: Pull request number
# Outputs: JSON response with review thread details or error message

set -e

OWNER="$1"
REPO="$2"
PR_NUMBER="$3"

if [[ -z "$OWNER" || -z "$REPO" || -z "$PR_NUMBER" ]]; then
  echo "Usage: fetch-review-threads.sh OWNER REPO PR_NUMBER" >&2
  exit 1
fi

# Source centralized sanitization functions
source "${CLAUDE_SKILL_DIR}/scripts/sanitize.sh"

# Safely escape user-provided repository identifiers before embedding in GraphQL
OWNER_ESCAPED=$(escape_graphql_string "$OWNER")
REPO_ESCAPED=$(escape_graphql_string "$REPO")

# Build GraphQL query for review threads (FINDING-2026-03-11-27 verified Step 2)
# Note: PR_NUMBER is numeric and doesn't need escaping for GraphQL injection
GRAPHQL_QUERY="query { repository(owner: \"$OWNER_ESCAPED\", name: \"$REPO_ESCAPED\") { pullRequest(number: $PR_NUMBER) { reviewThreads(first: 100) { nodes { id comments(first: 10) { nodes { databaseId } } isResolved } } } } }"

# Call GraphQL API
${CLAUDE_SKILL_DIR}/scripts/graphql-api.sh "$GRAPHQL_QUERY"
