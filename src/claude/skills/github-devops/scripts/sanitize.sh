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
  # Replace spaces with %20
  string="${string// /%20}"
  # Replace forward slashes with %2F
  string="${string//\//%2F}"
  # Replace quotes with %22
  string="${string//\"/%22}"
  # Replace hash with %23
  string="${string//#/%23}"
  # Replace ampersand with %26
  string="${string//\&/%26}"
  # Replace question mark with %3F
  string="${string//?/%3F}"
  echo "$string"
}
