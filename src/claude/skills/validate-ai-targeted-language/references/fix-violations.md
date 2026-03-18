# Fix Violations Phase

Apply automatic fixes to AI-targeted language violations with user approval.

## Input

- List of violations to fix
- Fix approach (all auto-fixes or interactive)
- File path and original content

## Steps

1. **Prepare fixes:**
   - Group violations by line number
   - Sort by descending line number (fix from bottom to top to preserve line numbers)
   - Generate replacement text for each fixable violation

2. **Common fix patterns:**

   **Third-person AI references:**
   - "The AI should" → "You should" or "MUST"
   - "The AI will" → "You will" or imperative verb
   - "The AI must" → "You must" or "MUST"
   - "The agent should/will/must" → Same as above
   - "Copilot should/will/must" → Same as above
   - "Claude Code should/will/must" → Same as above

   **Vague language:**
   - "try to [verb]" → "[verb]"
   - "consider [verb]ing" → "[verb]" or "Check whether to [verb]"
   - "maybe" → Remove or rephrase as conditional
   - "approximately/around/roughly [number]" → Context-dependent (may need manual review)

   **Missing imperative mood:**
   - "You can [verb]" → "[Verb]" (imperative)
   - "You might [verb]" → "[Verb]" or "MUST [verb]"
   - "It is recommended to" → "MUST" or imperative verb

3. **Apply fixes:**

   **If user chose "Fix all auto-fixable":**
   - Apply all fixes in one Edit operation
   - Build complete old_string → new_string mapping
   - Use Edit tool once for all changes
   - Report summary of applied fixes

   **If user chose "Review each violation":**
   - For each fixable violation:
     ```
     Line [N]: [violation-type]

     Current:
     ```
     [original text]
     ```

     Proposed fix:
     ```
     [fixed text]
     ```

     Apply this fix? (yes/no/skip-remaining)
     ```
   - On "yes": Add to fixes list
   - On "no": Skip this fix
   - On "skip-remaining": Exit fix phase with partial fixes
   - Apply accumulated fixes using Edit tool

4. **Verify fixes:**
   - Re-read file after Edit
   - Check that fixes were applied correctly
   - Verify line structure preserved
   - Report success or any issues

5. **Report results:**
   ```
   ✅ Fixed [N] violations
   ⚠️  [M] violations require manual review
   📝 File updated: [file-path]

   Remaining manual review items:
   - Line [X]: [description]
   - Line [Y]: [description]
   ```

## Output

- Updated file with fixes applied
- Summary of fixes applied
- List of remaining manual-review violations (if any)
- Success/failure status

## Important Notes

**MUST:**
- Fix from bottom to top to preserve line numbers
- Use Edit tool with precise old_string/new_string
- Verify each fix maintains sentence meaning
- Preserve surrounding whitespace and formatting
- Re-validate file after fixes to ensure no new violations introduced

**MUST NOT:**
- Apply fixes that change meaning
- Fix violations within code blocks or examples
- Proceed without user confirmation for each fix (if interactive mode)
- Skip verification step after applying fixes
- Leave file in inconsistent state if fixes fail

## Edge Cases

**Multiple violations on same line:**
- Apply all fixes for that line in a single replacement
- Show complete before/after for the line

**Fixes that require context:**
- Flag for manual review if replacement is ambiguous
- Provide explanation of why manual review needed

**Conflicting fixes:**
- Prioritize clarity and correctness
- Flag conflicts for user decision
