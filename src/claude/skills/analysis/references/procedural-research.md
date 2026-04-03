# Procedural Research Workflow

**This file is loaded when: You need to find, test, and verify a procedure or process.**

---

# Embedded Rules

## Documentation-First Response Requirements (from /src/claude/rules/documentation-first.md)

### Two-Stage Text Search (MANDATORY)

When searching for procedures within documentation, use a two-stage approach before concluding that a procedure is unavailable.

**Stage 1 — Keyword search:**
- Use Grep or search tools as the initial approach
- Try multiple related terms, synonyms, and variations
- Search for procedure names, command names, configuration options

**If Stage 1 yields no results or only false positives, proceed to Stage 2:**

**Stage 2 — Direct file examination:**
- Read the full relevant documentation files directly using Read tool
- Procedures, configuration guidelines, and step-by-step instructions are frequently expressed in natural language
- Do NOT report a procedure as unavailable until Stage 2 has been completed

**MUST NOT:**
- Report that procedure cannot be found after only a keyword search
- Treat search/grep returning zero results as confirmation that procedure does not exist

---

## Existing Rules

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

3. **Search and capture**: Search web/docs using WebFetch/WebSearch and capture ALL findings using the [Fact Capture Guidelines](fact-capture.md)

4. **Document procedures**: Document procedures found, variations, requirements, attempts, and results in fact files following [Fact Capture Guidelines](fact-capture.md)

5. **Test if possible**: If testing is possible, document all attempts and outcomes using Bash

6. **Iterate**: Keep capturing everything in fact files, refining based on test results using [Fact Capture Guidelines](fact-capture.md)

---

## Fact Capture

Use [Fact Capture Guidelines](fact-capture.md) to save all findings.

**When you capture findings:**

**MUST:**
- Use the folder-based organisation at `.memory/[topic]/` with structure specified in [Fact Capture Guidelines](fact-capture.md)
- Follow the entry format specified in [Fact Capture Guidelines](fact-capture.md): FINDING-YYYY-MM-DD-N with Captured, Source, and Verified fields
- Include source references for all findings (documentation, testing observation, URL)
- Timestamp each entry accurately
- Add `**Verified:** [NOT YET VERIFIED - requires verification workflow]` to every new finding
- Use the Write tool to create fact files, Edit tool to append findings
- Document procedures, variations, requirements, test results, and workarounds

**MUST NOT:**
- Use the flat `.memory/[topic]-facts.md` path (use folder structure instead)
- Mark findings as verified during fact-finding phase
- Edit existing findings during research
- Delete failed attempts
- Skip documenting workarounds or negative findings

---

## Testing Documentation

When you test procedures:

**MUST:**
- Document exact commands executed
- Record output/errors
- Note environment details (OS, versions)
- Indicate success/failure clearly
- Document workarounds discovered
- Use the format specified in [Fact Capture Guidelines](fact-capture.md)

**MUST NOT:**
- Skip environment details
- Omit error messages or failures
- Hide workarounds - capture them as findings

---

## Iterative Refinement

Continue iterating until you verify the procedure through successful testing.

**When you refine findings:**
- Append new findings to fact files (do not edit existing)
- Reference previous findings if building on them
- Note which variations work in which environments
- Capture dead ends and the reasons they failed

**MUST NOT:**
- Edit existing findings during research
- Delete failed attempts
- Skip documenting workarounds or failed approaches
