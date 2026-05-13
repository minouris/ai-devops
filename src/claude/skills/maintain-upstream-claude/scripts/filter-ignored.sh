#!/bin/bash

# Filter out gitignored files from input
# Usage: filter-ignored.sh < file_list.txt
# Reads file paths from stdin, outputs only non-ignored files

set -e

# Read from stdin and filter through git check-ignore
git check-ignore --verbose --stdin <<< "$(cat)" 2>/dev/null | awk '{print $NF}' || true

exit 0
