# Append Rejected Fact to Archive

Append this rejected fact to the archive file with complete rejection details.

---

## Execute

Append to the archive file created in Step 1 (`{basename}_archive_{yyyy-mm-dd}.md`).

---

## Format for Rejected Fact Entry

```markdown
## Rejected Fact {N}: {Brief Description}

**Original Fact:** {Exact factual statement from file}

**Original Citation:** {Citation that was in file, if any}

**Rejection Reason:** {Specific reason - outdated/inaccurate/unverifiable/superseded}

**Evidence:**
- Checked: {What sources were checked}
- Found: {What current information shows}
- Date: {When checked}

**Current Information:** {If fact is outdated, what is the current correct information}

**Archived:** YYYY-MM-DD

---
```

---

## Important Notes

**MUST:**
- Include complete rejection reason
- Specify what current information shows (if outdated)
- Preserve original fact statement exactly
- Append to existing archive file (do not overwrite)

**MUST NOT:**
- Omit rejection reason
- Skip documenting what was checked
- Delete the rejected fact from archive

---

## Output

**Updates:**
- Appends this rejected fact to `.memory/{basename}_archive_{date}.md`

**Next step:** Process next fact, or if all facts done: [Finalize and Log](finalize-and-log.md)
