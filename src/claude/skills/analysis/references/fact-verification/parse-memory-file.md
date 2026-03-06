# Parse Memory File

Read the memory file and extract all factual claims for verification.

---

## Execute

1. Read file at `${input:memoryFilePath}` using Read tool
2. Extract all factual claims (technical specifications, API details, behaviours, configurations)
3. Identify existing citations for each fact
4. For each fact, check whether it carries a `[VERIFIED on {date} by ...]` tag
5. Calculate days elapsed since each verification tag date
6. Mark facts verified within the last 30 days as SKIP (retain as accepted without re-verification)
7. Create list of remaining facts with their current citations for verification

---

## Important Notes

**MUST:**
- Extract EVERY factual claim, no matter how minor
- Note facts that lack citations
- Preserve context around each fact
- Record skipped facts (recently verified) separately in the log
- When evaluating a `[VERIFIED on {date} by {source}]` tag, parse the source field to determine which URL or process performed the verification

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

**Next step:** [Verify Facts](verify-facts.md)
