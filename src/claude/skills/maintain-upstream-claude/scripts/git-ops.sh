#!/bin/bash

# Git operations wrapper for the cloned repository
# Usage: git-ops.sh REPO_DIR OPERATION [ARGS...]
# REPO_DIR: Directory containing the git repository
# OPERATION: Operation to perform (checkout, add, commit, push, status, reset)
# ARGS: Arguments for the operation

set -e

REPO_DIR="$1"
OPERATION="$2"
shift 2

if [[ -z "$REPO_DIR" || -z "$OPERATION" ]]; then
  echo "Usage: git-ops.sh REPO_DIR OPERATION [ARGS...]" >&2
  echo "Operations: checkout, add, commit, push, status, reset" >&2
  exit 1
fi

case "$OPERATION" in
  checkout)
    git -C "$REPO_DIR" checkout "$@"
    ;;
  add)
    git -C "$REPO_DIR" add "$@"
    ;;
  commit)
    git -C "$REPO_DIR" commit "$@"
    ;;
  push)
    git -C "$REPO_DIR" push "$@"
    ;;
  status)
    git -C "$REPO_DIR" status "$@"
    ;;
  reset)
    git -C "$REPO_DIR" reset "$@"
    ;;
  *)
    echo "Error: Unknown operation '$OPERATION'" >&2
    exit 1
    ;;
esac

exit 0
