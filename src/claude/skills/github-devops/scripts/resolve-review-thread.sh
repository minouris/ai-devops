#!/bin/bash
# Resolve a review thread on a Pull Request via GitHub GraphQL API
# Usage: resolve-review-thread.sh THREAD_ID
# THREAD_ID: GraphQL node ID of the review thread (format: PRRT_kwD...)
# Outputs: JSON response with updated thread status or error message

set -e

THREAD_ID="$1"

if [[ -z "$THREAD_ID" ]]; then
  echo "Usage: resolve-review-thread.sh THREAD_ID" >&2
  exit 1
fi

# Source centralized sanitization functions
source "${CLAUDE_SKILL_DIR}/scripts/sanitize.sh"

# Safely escape thread ID before embedding in GraphQL mutation
THREAD_ID_ESCAPED=$(escape_graphql_string "$THREAD_ID")

# Build GraphQL mutation to resolve thread (FINDING-2026-03-11-05 verified mutation structure)
# FINDING-2026-03-11-27 verified working example with threadId parameter
GRAPHQL_QUERY="mutation { resolveReviewThread(input: { threadId: \"$THREAD_ID_ESCAPED\" }) { thread { id isResolved } } }"

# Call GraphQL API
${CLAUDE_SKILL_DIR}/scripts/graphql-api.sh "$GRAPHQL_QUERY"
