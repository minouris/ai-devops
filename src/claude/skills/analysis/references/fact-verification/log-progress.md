# Log Progress

Record verification run details in the verification log.

---

## Execute

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

## Output

**Updates:**
- `.memory/verification_log.md` with verification run details

**Next step:** Provide summary to user
