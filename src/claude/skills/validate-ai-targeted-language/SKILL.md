---
name: validate-ai-targeted-language
description: Validate and fix AI-targeted language violations in markdown files under /src/claude/
disable-model-invocation: false
release:
  publish: true
  platforms: [claude]
  validation:
    - ai-targeted-language
    - skill-structure
---

# AI-Targeted Language Validation Skill

Validate markdown files in `/src/claude/` against AI-targeted language standards and offer to fix violations automatically.

## Overview

This skill validates markdown files against the standards defined in [src/claude/rules/ai-targeted-language.md](../../rules/ai-targeted-language.md), checking for:

- Third-person AI references ("The AI should", "The agent must", "Copilot will")
- Vague language in instruction context ("try to", "consider", "maybe")
- Missing second-person address ("you") where instructions are given
- Missing imperative mood ("Create", "Use", "Verify") where instructions are given

When violations are found, the skill reports specific issues with line numbers and offers to fix them automatically.

## Workflow

See detailed workflow steps in:
- [references/check-violations.md](references/check-violations.md) - Detect violations
- [references/report-violations.md](references/report-violations.md) - Report findings
- [references/fix-violations.md](references/fix-violations.md) - Apply automatic fixes

## Usage

**Manual invocation:**
```
/validate-ai-targeted-language
```

**Automatic invocation:**
- Triggered by PostToolUse hook after Edit/Write operations on `/src/claude/**/*.md`
- Validates file after save but before commit
- Offers to fix violations interactively

## Important Notes

**MUST:**
- Check if file path matches `/src/claude/**/*.md` before validating
- Skip validation for `ai-targeted-language.md` itself (contains violation examples)
- Report violations with specific line numbers and context
- Offer to fix violations automatically with user confirmation
- Apply fixes using Edit tool to preserve file integrity

**MUST NOT:**
- Validate files outside `/src/claude/` directory
- Apply fixes without user confirmation
- Skip reporting violations even if auto-fix is available
- Modify files that fail validation without explicit user approval
