# Check Violations Phase

Detect AI-targeted language violations in markdown files.

## Input

- File path from PostToolUse hook or manual invocation
- User may specify a file path explicitly

## Steps

1. **Determine target file:**
   - If invoked by hook, extract file path from hook context
   - If manual invocation, ask user for file path or validate all `/src/claude/**/*.md` files
   - Verify file exists

2. **Check scope:**
   - If file path does NOT match `/src/claude/**/*.md`, exit with success (out of scope)
   - If file is `ai-targeted-language.md` itself, exit with success (skip validation - contains violation examples)

3. **Read required files:**
   - Read target file content
   - Read [src/claude/rules/ai-targeted-language.md](../../../rules/ai-targeted-language.md) for validation standards

4. **Check for violations:**

   **Third-person AI references:**
   - Search for: "The AI should", "The AI will", "The AI must"
   - Search for: "The agent should", "The agent will", "The agent must"
   - Search for: "Copilot should", "Copilot will", "Copilot must"
   - Search for: "Claude Code should", "Claude Code will", "Claude Code must"
   - Record line numbers and exact matches

   **Vague language:**
   - Search for: "try to", "consider", "maybe"
   - Search for: "approximately", "around", "roughly"
   - Exclude code blocks (lines between triple backticks)
   - Exclude quoted text (lines starting with `>`)
   - Exclude headings (lines starting with `#`)
   - Record line numbers and context

   **Missing second-person / imperative mood:**
   - Check instruction sections (MUST/MUST NOT blocks, numbered lists)
   - Look for patterns that should use "you" or imperative verbs
   - Record line numbers where instructions lack proper form

5. **Categorize violations:**
   - Group by type (third-person, vague language, missing imperative)
   - Sort by line number within each category
   - Identify fixable vs non-fixable violations

## Output

- List of violations with:
  - Line number
  - Violation type
  - Original text
  - Suggested fix (if available)
  - Fixable flag (boolean)

## Important Notes

**MUST:**
- Parse file line-by-line for accurate line numbers
- Preserve context around violations (show surrounding lines)
- Mark patterns that can be auto-fixed
- Skip code block contents and literal examples

**MUST NOT:**
- Report false positives from code examples or documentation about violations
- Miss violations by only checking partial patterns
- Fail to preserve file structure during parsing
