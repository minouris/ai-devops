# Report Violations Phase

Report validation findings to the user with clear, actionable information.

## Input

- List of violations from check-violations phase
- File path being validated
- Total violation count by category

## Steps

1. **Format violation report:**

   **Header:**
   ```
   🔍 AI-Targeted Language Validation Results

   File: [file-path]
   Violations found: [count]
   ```

   **For each violation category:**
   ```
   ## [Category Name] ([count] violations)

   ### Line [number]: [violation-type]

   **Found:**
   ```
   [original text with context]
   ```

   **Issue:** [explanation]

   **Suggested fix:**
   ```
   [corrected text]
   ```
   ```

2. **Display summary:**
   - Total violations by category
   - Count of auto-fixable violations
   - Count of violations requiring manual review

3. **Provide actionable options:**

   If auto-fixable violations exist:
   ```
   ✅ [N] violations can be fixed automatically
   ⚠️  [M] violations require manual review

   Would you like me to:
   1. Fix all auto-fixable violations
   2. Review each violation individually
   3. Skip fixes and continue
   ```

   If no auto-fixable violations:
   ```
   ⚠️  All [N] violations require manual review

   Please review the violations above and make corrections manually.
   ```

4. **Handle user response:**
   - Option 1: Proceed to fix-violations phase with all auto-fixes
   - Option 2: Proceed to fix-violations phase with interactive confirmation
   - Option 3: Exit with violation report only

## Output

- Formatted violation report displayed to user
- User selection for fix approach
- List of violations to fix (if user chooses to fix)

## Important Notes

**MUST:**
- Show line numbers for all violations
- Provide context (2-3 lines before/after) for each violation
- Clearly distinguish auto-fixable from manual-review violations
- Use emoji indicators for visual clarity (🔍 ✅ ⚠️ ❌)
- Link to ai-targeted-language.md for reference

**MUST NOT:**
- Overwhelm user with excessive detail
- Apply fixes without explicit user confirmation
- Hide violations that require manual review
- Proceed to fix phase if user declines
