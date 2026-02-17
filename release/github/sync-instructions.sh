#!/bin/bash
# Sync script for copilot instruction files from nightingale-truenas repository
# This script enables bidirectional sync between repos

set -e

SOURCE_REPO="minouris/nightingale-truenas"
SOURCE_BRANCH="main"

# Color output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Function to pull updates from source repo
pull_updates() {
    print_status "Pulling updates from $SOURCE_REPO..."

    # Main copilot instructions file
    gh api "repos/$SOURCE_REPO/contents/.github/copilot-instructions.md" --jq '.content' | base64 -d > .github/copilot-instructions.md

    # Instruction files
    for file in instruction-files.instructions.md plan-files.instructions.md prompt-files.instructions.md step-files.instructions.md; do
        gh api "repos/$SOURCE_REPO/contents/.github/instructions/$file" --jq '.content' | base64 -d > ".github/instructions/$file"
    done

    # Prompt files
    gh api "repos/$SOURCE_REPO/contents/.github/prompts/convert-plan-to-steps.prompt.md" --jq '.content' | base64 -d > .github/prompts/convert-plan-to-steps.prompt.md

    print_success "Successfully pulled updates from $SOURCE_REPO"

    # Show what changed
    if git diff --quiet .github/; then
        print_status "No changes detected"
    else
        print_status "Changes detected:"
        git diff --stat .github/
    fi
}

# Function to push updates back to source repo (requires write access)
push_updates() {
    print_error "Push functionality requires write access to $SOURCE_REPO"
    print_status "To push changes back to the source repository:"
    echo "  1. Fork or have write access to $SOURCE_REPO"
    echo "  2. Clone the source repo locally"
    echo "  3. Copy your modified files to the source repo"
    echo "  4. Create a pull request with your changes"
    echo ""
    print_status "Modified files in this repo:"
    git diff --name-only .github/ | grep -E '\.(md|instructions|prompt)$' || echo "  (no modified instruction files)"
}

# Main script
case "${1:-pull}" in
    pull)
        pull_updates
        ;;
    push)
        push_updates
        ;;
    *)
        echo "Usage: $0 {pull|push}"
        echo "  pull  - Pull updates from source repository (default)"
        echo "  push  - Show instructions for pushing changes back"
        exit 1
        ;;
esac
