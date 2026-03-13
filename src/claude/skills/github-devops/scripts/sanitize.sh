#!/bin/bash
# Centralized input sanitization utilities for GitHub DevOps skill
# Provides functions for safely escaping user input before embedding in APIs
# Source this script: source ${CLAUDE_SKILL_DIR}/scripts/sanitize.sh

# Escape JSON string - bash-native, no external dependencies
# Escapes special characters for safe embedding in JSON strings
# Usage: escaped=$(escape_json_string "$input")
escape_json_string() {
  local s="$1"
  # Escape backslashes first (must be first to avoid double-escaping)
  s="${s//\\/\\\\}"
  # Escape quotes
  s="${s//\"/\\\"}"
  # Escape newlines
  s="${s//$'\n'/\\n}"
  # Escape carriage returns
  s="${s//$'\r'/\\r}"
  # Escape tabs
  s="${s//$'\t'/\\t}"
  echo "$s"
}

# Escape GraphQL string - bash-native, no external dependencies
# Escapes special characters for safe embedding in GraphQL query strings
# GraphQL strings use the same escaping rules as JSON strings
# Usage: escaped=$(escape_graphql_string "$input")
escape_graphql_string() {
  local s="$1"
  # Escape backslashes first (must be first to avoid double-escaping)
  s="${s//\\/\\\\}"
  # Escape quotes
  s="${s//\"/\\\"}"
  # Escape newlines
  s="${s//$'\n'/\\n}"
  # Escape carriage returns
  s="${s//$'\r'/\\r}"
  # Escape tabs
  s="${s//$'\t'/\\t}"
  echo "$s"
}

# URL encode string - bash-native, no external dependencies
# Encodes special characters for safe use in URL paths
# Usage: encoded=$(url_encode "$input")
url_encode() {
  local string="$1"
  local length=${#string}
  local i char encoded="" hex

  # RFC 3986 unreserved characters: A-Z a-z 0-9 - . _ ~
  # All other bytes are percent-encoded as %HH
  for (( i=0; i<length; i++ )); do
    char="${string:i:1}"
    case "$char" in
      [a-zA-Z0-9.~_-])
        encoded+="$char"
        ;;
      *)
        printf -v hex '%%%02X' "'$char"
        encoded+="$hex"
        ;;
    esac
  done

  echo "$encoded"
}
