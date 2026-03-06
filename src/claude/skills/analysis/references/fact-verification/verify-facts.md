# Verify Facts

Check each fact against authoritative sources using WebFetch and WebSearch.

---

## Before Processing Each Fact

If a fact is tagged `[VERIFIED on {date} by ...]` and the tag date is within the last 30 days:
- Retain as ACCEPTED without fetching sources
- Preserve the existing tag unchanged
- Record as "retained — verified within 30 days" in the log

Re-verify regardless of tag age only when the user explicitly requests it (e.g., "force re-verify" or "verify all facts").

---

## For Each Fact Not Covered by Recent Verification Tag

**Execute:**

1. Identify the authoritative source for this fact
2. Use WebFetch to retrieve source content (if URL available)
3. Use WebSearch to find current authoritative source (if no URL or URL broken)
4. Check source publication/update date
5. Verify fact content matches source
6. Determine if fact is ACCEPTED or REJECTED

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
- Check EVERY fact, even if citation seems valid
- Fetch source content using WebFetch to verify fact accuracy
- Check for newer versions of documentation using WebSearch
- Note specific reason for rejection
- Record exact source URL and access date for accepted facts

**MUST NOT:**
- Accept facts without fetching sources
- Assume citations are correct without verification
- Skip verification for "obvious" facts
- Ignore date information
- Verify a sample and infer the rest are accurate
- Use statistical verification or sampling methods

---

## Output

**Creates:**
- List of accepted facts with verification details
- List of rejected facts with rejection reasons
- List of retained facts (skipped due to recent verification)

**Next step:** [Categorise Facts](categorise-facts.md)
