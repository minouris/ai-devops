# Session Summary Phase

You MUST provide a clear summary of artifacts created and next steps.

---

## Step 1: List Artifacts Created

**Query git for files created in this branch:**

```bash
git diff main...HEAD --name-status
```

Filter to:
- Files in `src/` directory
- With status: Added (A) or Modified (M)
- Matching artifact patterns (*.md, *.agent.md, *.skill.md, *.prompt.md)

**Build artifact list:**

```json
[
  {
    "path": "src/claude/skills/example/SKILL.md",
    "type": "skill",
    "platform": "claude",
    "name": "example",
    "validation_status": "passed" | "passed with warnings" | "failed"
  }
]
```

---

## Step 2: Show Validation Status

**For each artifact:**

Report validation status with details:

```
Artifacts Created in This Session:
===================================

1. example-skill (src/claude/skills/example/)
   Platform: claude
   Type: skill
   Validation: ✓ Passed
   - ✓ ai-targeted-language
   - ✓ uk-english
   - ✓ skill-structure
   - ✓ markdown-formatting

2. validator-agent (src/base/agents/validator.agent.md)
   Platform: base
   Type: agent
   Validation: ⚠ Passed with warnings
   - ✓ ai-targeted-language
   - ✓ uk-english
   - ⚠ 1 warning: file length approaching 500 lines
```

**Summarise:**
- Total artifacts created: N
- Fully validated: N
- With warnings: N
- Failed validation: N

---

## Step 3: Provide Next Steps

**Display next steps based on validation status:**

**If all artifacts passed validation:**

```
Authoring Complete!
===================

Branch: ai-artifact/{type}/{name}

All artifacts passed validation and are ready for publication.

Next Steps:
1. Run `/publish` to publish artifacts to release/ and create PR
2. Or continue authoring more artifacts in this branch by running `/author-ai` again

Note: Multiple artifacts can be published together in a single PR.
```

**If some artifacts have warnings:**

```
Authoring Complete with Warnings
=================================

Branch: ai-artifact/{type}/{name}

Some artifacts have validation warnings. Review warnings before publication.

Next Steps:
1. Review warnings listed above
2. Fix warnings if needed (re-run `/author-ai` or edit manually)
3. Run `/publish` to publish artifacts to release/ and create PR
```

**If any artifacts failed validation:**

```
Authoring Complete with Failures
=================================

Branch: ai-artifact/{type}/{name}

Some artifacts failed validation. These will be excluded from publication unless fixed.

Failed Artifacts:
- {artifact-name}: {violation-summary}

Next Steps:
1. Fix validation failures in failed artifacts
2. Re-run `/author-ai` to validate fixes, or
3. Run `/publish` to publish only passed artifacts
```

---

## Step 4: Remind About Branch Workflow

**Always include this reminder:**

```
Git Workflow Reminder:
======================

Current branch: ai-artifact/{type}/{name}
Base branch: main

Your changes remain in this feature branch until merged via PR.

To view changes:
  git diff main...HEAD

To continue authoring in this branch:
  /author-ai (will add to current branch)

To publish and create PR:
  /publish

To switch back to main (without merging):
  git checkout main
  (Your branch remains intact for later)
```

---

## Step 5: Offer to Continue or Exit

**Ask user:**

```
Would you like to:
1. Author another artifact in this branch
2. Publish artifacts and create PR
3. Exit (changes remain in branch)

Choose option (1/2/3):
```

**Handle user response:**

1. Return to artifact planning phase (Phase 1)
2. Invoke `/publish` skill
3. Report "Session complete. Branch preserved for later." and exit

---

## Important Notes

**MUST:**
- Summarise all artifacts created in session
- Show validation status for each
- Provide clear next steps
- Explain git workflow and branch state
- Offer user options for next action

**MUST NOT:**
- Exit without summary
- Leave user uncertain about next steps
- Merge or push without user action
- Auto-invoke `/publish` without user confirmation
