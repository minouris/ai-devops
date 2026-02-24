# Procedural Research Workflow

**This file is loaded when: The agent needs to find, test, and verify a procedure or process.**

---

## Embedded Rules

### Documentation-First (MANDATORY)

**MUST:**
- Search for and reference official documentation sources
- Verify information against authoritative sources before recording
- Use two-stage text search: keyword search → direct file examination
- Read documentation directly from files, not from cached context

**MUST NOT:**
- Rely solely on general knowledge or training data
- Report information unavailable after only keyword search
- Use cached documentation content without re-reading

---

## When to Use This Workflow

- Finding installation procedures
- Testing configuration steps
- Verifying deployment processes
- Documenting command sequences
- Any task requiring step-by-step verification

---

## Workflow Steps

1. **Clarify scope**: Ask what procedure is being researched and what the target context/environment is

2. **Confirm topic slug**: Confirm the topic slug with the user (e.g., `pterodactyl-install`); this is used for file naming and operation logging throughout this work

3. **Search and capture**: Search web/docs using WebFetch/WebSearch and capture ALL findings in the fact file `.memory/[topic]-facts.md`

4. **Document procedures**: Document procedures found, variations, requirements, attempts, and results in the fact file

5. **Test if possible**: If testing is possible, document all attempts and outcomes using Bash

6. **Iterate**: Keep capturing everything in the fact file, refining based on test results

7. **Wait for request**: Do NOT create a guide until the user explicitly requests one

---

## Fact Capture Format

Use `.memory/[topic]-facts.md` for capturing findings.

**Entry format:**
```markdown
### FINDING-YYYY-MM-DD-N
**Captured:** YYYY-MM-DD HH:MM
**Source:** [URL or observation]

[Finding description - procedure, variation, requirement, test result]

[Optional: Additional context, alternatives, or notes]
```

**Example:**
```markdown
### FINDING-2026-02-24-1
**Captured:** 2026-02-24 14:30
**Source:** https://docs.example.com/installation

Installation requires Python 3.9+ and Node.js 18+.

Tested on Ubuntu 22.04 - works as documented.
Alternative: Can use Docker image (example/app:latest) to skip dependency installation.
```

---

## Testing Documentation

When testing procedures:

**MUST:**
- Document exact commands run
- Record output/errors
- Note environment details (OS, versions)
- Indicate success/failure clearly
- Document workarounds discovered

**Testing entry format:**
```markdown
### FINDING-YYYY-MM-DD-N
**Captured:** YYYY-MM-DD HH:MM
**Source:** Testing on [environment]

Tested command: `[exact command]`
Result: [Success/Failed with error "..."]
Workaround: [if applicable]
Success: [confirmation]
```

**Example:**
```markdown
### FINDING-2026-02-24-2
**Captured:** 2026-02-24 14:45
**Source:** Testing on Ubuntu 22.04

Tested command: `npm install`
Result: Failed with error "EACCES: permission denied"
Workaround: Used `sudo npm install --unsafe-perm`
Success: Installation completed
```

---

## Iterative Refinement

Continue iterating until the procedure is verified through successful testing.

**When refining:**
- Add new findings to the fact file (don't edit existing)
- Reference previous findings if building on them
- Note which variations work in which environments
- Capture dead ends and why they failed

**MUST NOT:**
- Edit existing findings during research
- Delete failed attempts
- Skip documenting workarounds

---

## Final Output Creation

Do NOT create final output until the user explicitly requests it.

Final output is verified procedure documentation (e.g., `pterodactyl-installation-guide.md`).

When user requests final output:
1. Review fact file containing tested procedures
2. Extract verified working procedure
3. Present draft guide in `.memory/[GUIDE-NAME]-PENDING.md`
4. Include all steps, requirements, troubleshooting notes
5. After user approval, create final guide in specified location
