#!/bin/bash
# Centralized input sanitization utilities for GitHub DevOps skill
# Provides functions for safely escaping user input before embedding in APIs
# Source this script: source ${CLAUDE_SKILL_DIR}/scripts/sanitize.sh

# Escape JSON string - bash-native, no external dependencies
# Escapes special characters for safe embedding in JSON strings
# Covers all characters required by RFC 8259: \, ", and control chars 0x00-0x1F
# Usage: escaped=$(escape_json_string "$input")
escape_json_string() {
  local s="$1"
  # Escape backslashes first (must be first to avoid double-escaping)
  s="${s//\\/\\\\}"
  # Escape quotes
  s="${s//\"/\\\"}"
  # Escape named control characters (RFC 8259 §7)
  s="${s//$'\n'/\\n}"
  s="${s//$'\r'/\\r}"
  s="${s//$'\t'/\\t}"
  s="${s//$'\b'/\\b}"
  s="${s//$'\f'/\\f}"
  # Escape remaining ASCII control characters 0x01-0x07, 0x0B, 0x0E-0x1F
  # (0x00 cannot appear in bash strings; 0x08/09/0A/0C/0D handled above)
  local i ctrl hex
  for i in 1 2 3 4 5 6 7 11 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31; do
    ctrl=$(printf "\\$(printf '%03o' "$i")")
    hex=$(printf '\\u%04x' "$i")
    s="${s//$ctrl/$hex}"
  done
  echo "$s"
}

# Escape GraphQL string - bash-native, no external dependencies
# Escapes special characters for safe embedding in GraphQL query strings
# GraphQL strings use the same escaping rules as JSON strings (RFC 8259 §7)
# Usage: escaped=$(escape_graphql_string "$input")
escape_graphql_string() {
  local s="$1"
  # Escape backslashes first (must be first to avoid double-escaping)
  s="${s//\\/\\\\}"
  # Escape quotes
  s="${s//\"/\\\"}"
  # Escape named control characters (RFC 8259 §7)
  s="${s//$'\n'/\\n}"
  s="${s//$'\r'/\\r}"
  s="${s//$'\t'/\\t}"
  s="${s//$'\b'/\\b}"
  s="${s//$'\f'/\\f}"
  # Escape remaining ASCII control characters 0x01-0x07, 0x0B, 0x0E-0x1F
  # (0x00 cannot appear in bash strings; 0x08/09/0A/0C/0D handled above)
  local i ctrl hex
  for i in 1 2 3 4 5 6 7 11 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31; do
    ctrl=$(printf "\\$(printf '%03o' "$i")")
    hex=$(printf '\\u%04x' "$i")
    s="${s//$ctrl/$hex}"
  done
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
