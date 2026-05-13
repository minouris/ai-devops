#!/bin/bash

# Initialize temporary directory for skill operations
# Usage: init.sh
# Creates .tmp directory in workspace root (relative to current working directory)

set -e

# Create .tmp directory if it doesn't exist
mkdir -p .tmp

echo "Temporary directory initialized: .tmp/" >&2
exit 0
