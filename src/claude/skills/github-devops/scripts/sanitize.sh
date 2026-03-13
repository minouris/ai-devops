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
  # Escape remaining ASCII control characters 0x01-0x1F
  # (0x00 cannot appear in bash strings; 0x08/09/0A/0C/0D handled above)
  local i ctrl hex
  for ((i=1; i<=31; i++)); do
    case $i in 8|9|10|12|13) continue;; esac
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
  # Escape remaining ASCII control characters 0x01-0x1F
  # (0x00 cannot appear in bash strings; 0x08/09/0A/0C/0D handled above)
  local i ctrl hex
  for ((i=1; i<=31; i++)); do
    case $i in 8|9|10|12|13) continue;; esac
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
