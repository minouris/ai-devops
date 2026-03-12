#!/bin/bash
# Fetch comments on a Pull Request via GitHub REST API
# Usage: fetch-thread-comments.sh OWNER REPO PR_NUMBER
# OWNER: Repository owner
# REPO: Repository name
# PR_NUMBER: Pull request number
# Outputs: JSON array of comments or error message

set -e

OWNER="$1"
REPO="$2"
PR_NUMBER="$3"

if [[ -z "$OWNER" || -z "$REPO" || -z "$PR_NUMBER" ]]; then
  echo "Usage: fetch-thread-comments.sh OWNER REPO PR_NUMBER" >&2
  exit 1
fi

# Source centralized sanitization functions
source "${CLAUDE_SKILL_DIR}/scripts/sanitize.sh"

# Safely encode repository identifiers for URL path
OWNER_ENCODED=$(url_encode "$OWNER")
REPO_ENCODED=$(url_encode "$REPO")

# Call REST API to get PR comments (FINDING-2026-03-11-27 Step 1 verified pattern)
${CLAUDE_SKILL_DIR}/scripts/rest-api.sh GET "/repos/$OWNER_ENCODED/$REPO_ENCODED/pulls/$PR_NUMBER/comments"
