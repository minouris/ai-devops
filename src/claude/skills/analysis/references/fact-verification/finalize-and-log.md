# Finalize and Log

Complete verification working document and archive file, rewrite memory file with verified facts only, and log progress.

---

## Execute

### 1. Finalize Verification Working Document

Append to `.memory/{basename}-verification-working.md`:

```markdown
## Verification Summary

**Findings verified:** {N} fully verified, {N} partially verified, {N} rejected

**Primary sources consulted:**
- [Source Name](URL)
- [Source Name](URL)

{Summary of verification results}
```

---

### 2. Finalize Archive File

Append to `.memory/{basename}_archive_{date}.md`:

```markdown
## Archive Notes

- Total facts checked: {N}
- Facts rejected: {N}
- Facts accepted: {N}
- Facts retained (within 30-day window): {N}
- Verification method: WebFetch, WebSearch
- Authoritative sources consulted: {list}

---
```

---

### 3. Rewrite Memory File

Rewrite the original memory file using Write tool:

**Updated File Header:**
```markdown
# {File Title}

**Last Verified:** YYYY-MM-DD
**Verification Method:** Source checking via WebFetch/WebSearch
**Verification Details:** See {verification-working-filename}
**Archived Facts:** See {archive filename}

---
```

**Content:**
- Include ALL accepted facts with their verification tags (added during Step 2)
- Include ALL retained facts (within 30-day window) with their original tags unchanged
- Do NOT include rejected facts (they are in archive)
- Preserve any non-factual content (structure, notes, TODOs)
- Maintain logical organisation

---

### 4. Log Progress

Create or update `.memory/verification_log.md` with an entry for this run:

```markdown
## Verification: {filename} - YYYY-MM-DD HH:MM:SS

**Source File:** {memory file path}
**Verification Working Document:** {verification working file path}
**Archive File:** {archive file path}
**Started:** YYYY-MM-DD HH:MM:SS
**Completed:** YYYY-MM-DD HH:MM:SS

**Summary:**
- Total facts processed: {N}
- Facts newly verified (tagged): {N}
- Facts retained (within 30-day window, skipped): {N}
- Facts rejected (archived): {N}
- Sources checked: {N}

**Newly Verified Facts:**
- {Brief list of accepted fact topics}

**Retained Facts (skipped — recent tag):**
- {Brief list with tag dates and expiry dates}

**Rejected Facts:**
- {Brief list of rejected fact topics with reasons}

**Tools Used:**
- WebFetch: {N} calls
- WebSearch: {N} queries

**Issues Encountered:**
- {Any problems during verification}

---
```

---

## Important Notes

**MUST:**
- Complete all files before finishing
- Rewrite memory file with only accepted and retained facts
- Include file header with references to working document and archive
- Log complete verification details

**MUST NOT:**
- Leave files incomplete
- Include rejected facts in updated memory file
- Omit log entry

---

## Output

**Finalizes:**
- `.memory/{basename}-verification-working.md` (complete with summary)
- `.memory/{basename}_archive_{date}.md` (complete with notes)
- Original memory file (rewritten with verified facts only)
- `.memory/verification_log.md` (appended with this run's details)

**Next step:** Provide summary to user
