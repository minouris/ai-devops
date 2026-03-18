#!/bin/bash
# Respond to a review comment on a Pull Request via GitHub REST API
# Usage: respond-to-comment.sh OWNER REPO PR_NUMBER COMMENT_ID REPLY_TEXT
# OWNER: Repository owner
# REPO: Repository name
# PR_NUMBER: Pull request number
# COMMENT_ID: Comment ID to reply to
# REPLY_TEXT: Text of the reply
# Outputs: JSON response with new comment details or error message

set -e

OWNER="$1"
REPO="$2"
PR_NUMBER="$3"
COMMENT_ID="$4"
REPLY_TEXT="$5"

if [[ -z "$OWNER" || -z "$REPO" || -z "$PR_NUMBER" || -z "$COMMENT_ID" || -z "$REPLY_TEXT" ]]; then
  echo "Usage: respond-to-comment.sh OWNER REPO PR_NUMBER COMMENT_ID REPLY_TEXT" >&2
  exit 1
fi

# Source centralized sanitization functions
source "${CLAUDE_SKILL_DIR}/scripts/sanitize.sh"

# Safely sanitize user-provided reply text before embedding in JSON
REPLY_TEXT_ESCAPED=$(escape_json_string "$REPLY_TEXT")

# Safely encode repository identifiers for URL path
OWNER_ENCODED=$(url_encode "$OWNER")
REPO_ENCODED=$(url_encode "$REPO")

# Build JSON payload for comment reply (FINDING-2026-03-11-13 verified correct parameter is "in_reply_to")
PAYLOAD=$(cat <<EOF
{
  "body": "$REPLY_TEXT_ESCAPED",
  "in_reply_to": $COMMENT_ID
}
EOF
)

# Call REST API to create reply comment
${CLAUDE_SKILL_DIR}/scripts/rest-api.sh POST "/repos/$OWNER_ENCODED/$REPO_ENCODED/pulls/$PR_NUMBER/comments" "$PAYLOAD"
