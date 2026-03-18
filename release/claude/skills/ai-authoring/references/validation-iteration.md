# Validation and Iteration Phase

You MUST validate artifacts against specified rules and guide users to fix violations.

---

## Step 1: Invoke Validator Agent

**Spawn validator agent:**

Use Task tool to spawn validator with artifact specifications:

```
Task(
  subagent_type="general-purpose",
  description="Validate AI artifact",
  prompt=f"""
  You are the validator agent. Validate this artifact:

  Artifact: src/{platform}/{type}/{name}/
  Validation rules: {validation_rules}

  Read the artifact and check for violations of each specified rule.
  Output JSON format with violations.
  """
)
```

**Parse validator output:**

Expected format:
```json
{
  "artifact": "path/to/artifact",
  "validation_rules": ["rule1", "rule2"],
  "status": "pass" | "fail",
  "violations": [...]
}
```

---

## Step 2: Report Violations

**If validation passed:**

Report:
```
✓ Validation passed

All checks passed:
- ai-targeted-language
- documentation-standards
- markdown-formatting

Artifact is ready for publication.
```

Proceed to session summary phase.

**If validation failed:**

Report violations with line numbers:

```
✗ Validation failed

Violations found:

1. Line 45: Third-person reference "The AI should"
   Rule: ai-targeted-language
   Fix: Use "You must" or "Create" instead

2. Line 67: US English spelling "organized"
   Rule: documentation-standards
   Fix: Change to "organised"

3. Line 89: Bold text used as heading "**Implementation:**"
   Rule: documentation-standards
   Fix: Use proper heading: "## Implementation"

Would you like to:
1. Fix violations now
2. Accept violations and proceed (not recommended)
3. Abort authoring

Choose option (1/2/3):
```

---

## Step 3: Guide User to Fix Issues

**If user chooses option 1 (fix violations):**

For each violation:

1. **Show violation context:**
   - Line number
   - Surrounding lines for context
   - Specific issue
   - Suggested fix

2. **Prompt user:**
   - "Fix violation at line {N}?"
   - Show suggested correction
   - Ask: "Apply this fix? (yes/no/custom)"

3. **Apply fix:**
   - If yes: Use Edit tool to apply suggested fix
   - If custom: Ask user for custom fix text, then apply
   - If no: Skip this violation

4. **Re-read artifact:**
   - Verify fix applied correctly
   - Show updated content

**After all fixes:**

Stage and commit fixes:

```bash
git add src/{platform}/{type}/{name}/
git commit -m "Fix validation issues in {name}

- Fixed: {list of violations fixed}"
```

---

## Step 4: Re-validate

**After fixes committed:**

Re-run validator agent with same parameters.

**If still has violations:**

Report remaining violations and repeat fix process.

**If validation passed:**

Report success and proceed to session summary.

---

## Step 5: Handle User Choice to Accept Violations

**If user chooses option 2 (accept violations):**

Warn:
```
⚠ Warning: Proceeding with validation violations

The artifact has known compliance issues. It may be rejected during publication.

Violations:
- {list violations}

Confirm you want to proceed with these violations? (yes/no)
```

If yes:
- Mark artifact as "validated with warnings"
- Proceed to session summary

If no:
- Return to fix process

**If user chooses option 3 (abort):**

Report:
```
Authoring aborted

Changes remain in branch: ai-artifact/{type}/{name}

To resume:
1. Fix violations manually
2. Re-run /author-ai or
3. Delete branch: git branch -D ai-artifact/{type}/{name}
```

Halt workflow.

---

## Important Notes

**MUST:**
- Validate immediately after artifact creation
- Report all violations with line numbers and suggestions
- Guide user through fix process
- Commit fixes immediately after applying
- Re-validate after fixes
- Repeat until validation passes or user accepts violations

**MUST NOT:**
- Skip validation
- Proceed without user confirmation when violations exist
- Batch fixes across multiple validation rounds (fix and commit incrementally)
- Auto-fix without user confirmation
