# Session Consolidation Prompt

**Purpose:** Extract verified, useful information from the current session and consolidate it into a single handoff file for the next session.

## Instructions

Review the entire conversation context and extract **only verified facts** into `.memory/HANDOFF.md`.

### What to Extract

**MUST Include (Verified Facts Only):**
- Service configurations that were tested and confirmed working
- API endpoints, methods, parameters that were successfully used
- Authentication methods and credential locations (not the secrets themselves)
- File paths and directory structures created/modified
- Working commands and their purposes
- Integration points between components
- Known limitations discovered through testing
- Architecture decisions that were implemented
- Issues encountered with confirmed workarounds

**MUST NOT Include:**
- Speculation or untested theories
- Failed approaches (unless documenting what NOT to do)
- Verbose explanations or reasoning (keep it factual)
- Large code blocks (reference file paths instead)
- Temporary debugging notes
- Step-by-step execution logs (those go in PROGRESS files)

### Consolidation Process

1. **Read existing `.memory/HANDOFF.md`** (if it exists)
2. **Scan current session** for verified discoveries
3. **Update sections** with new information
4. **Remove outdated** information that was superseded
5. **Keep it concise** - target 1-2 pages maximum
6. **Verify accuracy** - only include what was proven to work

### HANDOFF.md Structure

```markdown
# Project Handoff

**Last Updated:** YYYY-MM-DD HH:MM
**Current State:** [Brief 1-line status]

---

## Environment

**Container:** devcontainer type/image
**Key Tools:** tool1 v1.2.3, tool2 v4.5.6
**Languages:** language versions

---

## Services & Components

### {Service Name}
- **Purpose:** One-line description
- **Location:** URL/path
- **Auth:** How authentication works (not credentials)
- **Key Files:** Important files and their purposes
- **Config:** Critical configuration details
- **Integration:** How it connects to other components

[Repeat for each service/component]

---

## File Structure

```
workspace/
├── component1/          # Purpose
│   ├── file1.ext       # What it does
│   └── file2.ext       # What it does
└── component2/          # Purpose
```

---

## Working Commands

**Purpose:** Brief description
```bash
command here
```

[Repeat for each important command]

---

## Credentials & Access

**File:** `.memory/{SERVICE}_CREDENTIALS.md`
**Contents:** List what credentials are stored (not the values)

---

## Known Issues & Workarounds

**Issue:** Brief problem description
**Workaround:** Brief solution
**Reference:** `.memory/ISSUES.md #{number}`

[Repeat for critical issues only]

---

## Current Work

**Focus:** What we're currently working on
**Next Steps:** Immediate next actions (1-3 items max)
**Blocked By:** Any blockers (if applicable)

---

## Quick Reference

**{Topic}:** Key fact or command
[Repeat for frequently-needed info]
```

### Execution

When user says: **"Consolidate this session"**, **"Prepare handoff"**, or similar:

1. Create or update `.memory/HANDOFF.md` following the structure above
2. Keep it under 2 pages (approximately 200 lines of Markdown)
3. Focus on answers, not questions
4. Prioritize what's needed to continue work immediately
5. Confirm completion: "Session consolidated. Include `.memory/HANDOFF.md` in your next session to maintain context."

### Optional: Detailed Memory Files

If there are detailed discoveries worth preserving beyond the handoff:
- Technical details → `.memory/{SERVICE}_INFO.md`
- Execution history → `.memory/PLAN_{N}_PROGRESS.md`
- Wrong assumptions → `.memory/ASSUMPTION_LOG.md`

But these are supplementary. **HANDOFF.md is the primary continuity file.**
