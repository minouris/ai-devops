#!/bin/bash
# Create a Pull Request via GitHub REST API
# Usage: create-pr.sh OWNER REPO HEAD BASE TITLE BODY
# OWNER: Repository owner
# REPO: Repository name
# HEAD: Branch to merge (e.g., feature-branch)
# BASE: Target branch (e.g., main)
# TITLE: PR title
# BODY: PR description
# Outputs: JSON response with PR details or error message

set -e

OWNER="$1"
REPO="$2"
HEAD="$3"
BASE="$4"
TITLE="$5"
BODY="$6"

if [[ -z "$OWNER" || -z "$REPO" || -z "$HEAD" || -z "$BASE" || -z "$TITLE" ]]; then
  echo "Usage: create-pr.sh OWNER REPO HEAD BASE TITLE [BODY]" >&2
  exit 1
fi

# Source centralized sanitization functions
source "${CLAUDE_SKILL_DIR}/scripts/sanitize.sh"

# Safely sanitize all user-provided text before embedding in JSON
TITLE_ESCAPED=$(escape_json_string "$TITLE")
BODY_ESCAPED=$(escape_json_string "$BODY")
HEAD_ESCAPED=$(escape_json_string "$HEAD")
BASE_ESCAPED=$(escape_json_string "$BASE")

# Safely encode repository identifiers for URL path
OWNER_ENCODED=$(url_encode "$OWNER")
REPO_ENCODED=$(url_encode "$REPO")

# Build JSON payload for PR creation (FINDING-2026-03-11-10 verified operation)
PAYLOAD=$(cat <<EOF
{
  "title": "$TITLE_ESCAPED",
  "head": "$HEAD_ESCAPED",
  "base": "$BASE_ESCAPED",
  "body": "$BODY_ESCAPED"
}
EOF
)

# Call REST API to create PR
${CLAUDE_SKILL_DIR}/scripts/rest-api.sh POST "/repos/$OWNER_ENCODED/$REPO_ENCODED/pulls" "$PAYLOAD"
