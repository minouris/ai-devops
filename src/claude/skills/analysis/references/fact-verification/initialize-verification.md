# Initialize Verification

Read the memory file, extract all facts, and prepare verification working document and archive file.

---

## Execute

1. Read file at `${input:memoryFilePath}` using Read tool
2. Extract all factual claims (technical specifications, API details, behaviours, configurations)
3. Identify existing citations for each fact
4. For each fact, check whether it carries a `[VERIFIED on {date} by ...]` tag
5. Calculate days elapsed since each verification tag date
6. Mark facts verified within the last 30 days as SKIP (retain as accepted without re-verification)
7. Create list of facts requiring verification (excluding recently verified)
8. Create verification working document with header
9. Create archive file with header

---

## Verification Working Document Header

Determine filename: `${input:memoryFilePath}` → `{basename}-verification-working.md`

Create file with:

```markdown
# {Topic} Verification Working Document

Comprehensive verification of all findings in {source-file} against official documentation sources.

**Primary sources:**
(will be populated as facts are verified)

**Verification date:** YYYY-MM-DD

---
```

---

## Archive File Header

Determine filename: `${input:memoryFilePath}` → `{basename}_archive_{yyyy-mm-dd}.md`

Create file with:

```markdown
# {Basename} Archive - {Date}

**Archive Date:** YYYY-MM-DD
**Source File:** {original memory file path}
**Archived By:** verify-memory-facts process

**Purpose:** This file contains facts from {source file} that were found to be
outdated, inaccurate, or unverifiable during fact verification on {date}.

---

## Rejected Facts

(will be populated as facts are rejected)

---
```

---

## Important Notes

**MUST:**
- Extract EVERY factual claim, no matter how minor
- Note facts that lack citations
- Preserve context around each fact
- Record skipped facts (recently verified) separately in the log
- When evaluating a `[VERIFIED on {date} by {source}]` tag, parse the source field to determine which URL or process performed the verification
- Create both working document and archive file during initialization

**MUST NOT:**
- Skip facts that seem obviously correct (unless they carry a recent verification tag)
- Ignore facts without citations
- Make assumptions about what constitutes a "fact"
- Re-verify facts tagged within the last 30 days unless the user explicitly requests it

---

## Output

**Creates:**
- List of facts requiring verification (excluding recently verified)
- List of recently verified facts to skip
- Context for each fact
- `.memory/{basename}-verification-working.md` (header only)
- `.memory/{basename}_archive_{date}.md` (header only)

**Next step:** Process each fact through [Verify Facts](verify-facts.md) → [Create Verification Working Document](create-verification-working-document.md) → [Update Memory File](update-memory-file.md) or [Create Archive](create-archive.md)
