# Verify Facts

Check a single fact against authoritative sources using WebFetch and WebSearch.

---

## Before Processing This Fact

If the fact is tagged `[VERIFIED on {date} by ...]` and the tag date is within the last 30 days:
- Skip to next fact (this fact was retained as ACCEPTED in Step 1)
- Preserve the existing tag unchanged
- Was already recorded as "retained — verified within 30 days" in initialization

Re-verify regardless of tag age only when the user explicitly requests it (e.g., "force re-verify" or "verify all facts").

---

## Verify This Fact

**Execute:**

1. Identify the authoritative source for this fact
2. Use WebFetch to retrieve source content (if URL available)
3. Use WebSearch to find current authoritative source (if no URL or URL broken)
4. Check source publication/update date
5. Verify fact content matches source
6. Determine if this fact is ACCEPTED or REJECTED

---

## Verification Criteria

**ACCEPTED if:**
- Fact matches content in authoritative source
- Source is current (published/updated within reasonable timeframe for topic)
- Source is authoritative (official docs, official repos, official release notes)
- Citation is complete and accessible

**REJECTED if:**
- Fact contradicts current source
- Source is outdated (check for newer versions/docs)
- Source is not authoritative
- Fact cannot be verified (source unavailable, citation missing, no authoritative source exists)
- Fact has been superseded by newer information

---

## Important Notes

**MUST:**
- Fetch source content using WebFetch to verify fact accuracy
- Check for newer versions of documentation using WebSearch
- Note specific reason for rejection
- Record exact source URL and access date for accepted facts

**MUST NOT:**
- Accept facts without fetching sources
- Assume citations are correct without verification
- Skip verification for "obvious" facts
- Ignore date information

---

## Output

**Returns for this fact:**
- ACCEPTED or REJECTED status
- Verification details (source URL, dates, evidence)
- Rejection reason (if REJECTED)

**Next step:** [Document this fact's verification](create-verification-working-document.md)
