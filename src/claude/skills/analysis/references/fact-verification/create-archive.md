# Create Archive

Archive rejected facts with complete rejection reasons and evidence.

---

## Execute

1. Determine archive filename from input path:
   - `${input:memoryFilePath}` → `{basename}_archive_{yyyy-mm-dd}.md`
   - Example: `.memory/analysis_facts_pending.md` → `.memory/analysis_facts_pending_archive_2026-02-19.md`

2. Create archive file using Write tool with the structure below

---

## Archive File Structure

```markdown
# {Basename} Archive - {Date}

**Archive Date:** YYYY-MM-DD
**Source File:** {original memory file path}
**Archived By:** verify-memory-facts process

**Purpose:** This file contains facts from {source file} that were found to be
outdated, inaccurate, or unverifiable during fact verification on {date}.

---

## Rejected Facts

{Insert all rejected facts from Step 3, with full rejection reasons}

---

## Archive Notes

- Total facts checked: {N}
- Facts rejected: {N}
- Facts accepted: {N}
- Verification method: WebFetch, WebSearch
- Authoritative sources consulted: {list}

---
```

---

## Important Notes

**MUST:**
- Include complete rejection reasons
- Specify what current information shows (if outdated)
- Record verification methodology
- Preserve original fact statements exactly

**MUST NOT:**
- Delete rejected facts without archiving
- Omit rejection reasons
- Archive accepted facts

---

## Output

**Creates:**
- `.memory/{basename}_archive_{date}.md` with all rejected facts

**Next step:** [Update Memory File](update-memory-file.md)
