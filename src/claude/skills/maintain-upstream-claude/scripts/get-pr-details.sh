#!/bin/bash

# Fetch PR details and comments using REST API
# Usage: get-pr-details.sh REPO PR_NUMBER
# Outputs: JSON data containing PR details and comments

set -e

REPO="$1"
PR_NUMBER="$2"

if [[ -z "$REPO" || -z "$PR_NUMBER" ]]; then
  echo "Usage: get-pr-details.sh REPO PR_NUMBER" >&2
  exit 1
fi

# Extract token from git credential helper
gh_token=$(printf 'protocol=https\nhost=github.com\n' | git credential fill 2>/dev/null | grep '^password=' | cut -d'=' -f2)

if [[ -z "$gh_token" ]]; then
  echo "Error: GitHub token not available" >&2
  exit 1
fi

# Fetch PR details
curl -s -H "Authorization: token $gh_token" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/$REPO/pulls/$PR_NUMBER"

echo "---COMMENTS_SEPARATOR---"

# Fetch inline review comments
curl -s -H "Authorization: token $gh_token" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/$REPO/pulls/$PR_NUMBER/comments"

echo "---GENERAL_COMMENTS_SEPARATOR---"

# Fetch general PR comments
curl -s -H "Authorization: token $gh_token" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/$REPO/issues/$PR_NUMBER/comments"
