---
name: validate-ai-targeted-language
description: Validates markdown files in /src/claude/ against AI-targeted language standards on save
event: PostToolUse
release:
  publish: true
  platforms: [claude]
  validation:
    - ai-targeted-language
    - hook-structure
---

# Validate AI-Targeted Language Hook

Validates markdown files in `/src/claude/` against AI-targeted language standards whenever they are modified using Edit or Write operations.

## Event Trigger

- **Event:** PostToolUse
- **Tool Filter:** Edit, Write
- **Path Filter:** `/src/claude/**/*.md`

## Validation Checks

Searches for common AI-targeted language violations:

1. **Third-person AI references:**
   - "The AI should", "The AI will", "The AI must"
   - "The agent should", "The agent will", "The agent must"
   - "Copilot should", "Copilot will", "Copilot must"
   - "Claude Code should", "Claude Code will", "Claude Code must"

2. **Vague language:**
   - "try to", "consider", "maybe"
   - "approximately", "around", "roughly"

3. **Conditional instruction language:**
   - "might", "could", "may" (when giving instructions)

## Shell Command

```bash
#!/bin/bash

# Get the file path from the tool use event
FILE_PATH="${TOOL_FILE_PATH:-}"

# Exit if no file path provided
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Only validate markdown files in /src/claude/
if [[ ! "$FILE_PATH" =~ /src/claude/.*\.md$ ]]; then
  exit 0
fi

# Skip validation for certain files that document violations
if [[ "$FILE_PATH" =~ /ai-targeted-language\.md$ ]]; then
  exit 0
fi

echo "🔍 Validating AI-targeted language: $FILE_PATH"

VIOLATIONS=""

# Check for third-person AI references
if grep -i -E "(the AI should|the AI will|the AI must|the agent should|the agent will|the agent must|copilot should|copilot will|copilot must|claude code should|claude code will|claude code must)" "$FILE_PATH" > /dev/null 2>&1; then
  VIOLATIONS="${VIOLATIONS}\n❌ Third-person AI reference found (use 'you' instead)"
fi

# Check for vague language in instruction context
if grep -i -E "(try to|consider|maybe|approximately|around|roughly)" "$FILE_PATH" | grep -v "^>" | grep -v "^#" | grep -v "\`" > /dev/null 2>&1; then
  VIOLATIONS="${VIOLATIONS}\n⚠️  Vague language found (use precise, unambiguous language)"
fi

# Report violations
if [ -n "$VIOLATIONS" ]; then
  echo -e "\n⚠️  AI-Targeted Language Violations Detected:"
  echo -e "$VIOLATIONS"
  echo ""
  echo "📋 Review src/claude/rules/ai-targeted-language.md for standards"
  echo "💡 Use second-person 'you' and imperative mood for AI instructions"
  exit 1
fi

echo "✅ AI-targeted language validation passed"
exit 0
```

## Exit Code Behavior

- **Exit 0:** Validation passed or file not applicable
- **Exit 1:** Validation failed - blocks the operation and displays violations

## Security

**MUST:**
- Validate file path before reading
- Skip files outside `/src/claude/`
- Skip the ai-targeted-language.md rule file itself (contains violation examples)

**MUST NOT:**
- Execute unvalidated file paths
- Expose sensitive data in error messages
