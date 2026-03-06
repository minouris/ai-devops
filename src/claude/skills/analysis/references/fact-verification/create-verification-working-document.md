# Create Verification Working Document

Generate a comprehensive verification document with detailed evidence for each finding.

---

## Execute

1. Determine verification working filename from input path:
   - `${input:memoryFilePath}` → `{basename}-verification-working.md`
   - Example: `.memory/claude-config-compaction-facts.md` → `.memory/claude-config-compaction-verification-working.md`

2. Create verification working document using Write tool with the structure below

---

## Verification Working Document Structure

```markdown
# {Topic} Verification Working Document

Comprehensive verification of all findings in {source-file} against official documentation sources.

**Primary sources:**
- [Source Name](URL)
- [Source Name](URL)

**Verification date:** YYYY-MM-DD

---

## FINDING-YYYY-MM-DD-N: {Finding Title}

**Claim:** {Brief summary of what the finding claims}

**Verification:**

From [Source Name](URL):

> "{Exact quote from source that verifies the claim}"

{Additional quotes or evidence as needed}

**Status:** ✅ VERIFIED - {Summary of verification result}
{or}
**Status:** ⚠️ PARTIALLY VERIFIED - {What was verified, what wasn't}
{or}
**Status:** ❌ REJECTED - {Why it was rejected}

---

{Repeat for each finding}

---

## Verification Summary

**Findings verified:** {N} fully verified, {N} partially verified

{Summary of verification results}
```

---

## Important Notes

**MUST:**
- Include detailed evidence for each finding's verification
- Provide exact quotes from sources where possible
- Document verification status clearly
- Use markdown heading anchors that match the finding identifiers (e.g., `## FINDING-2026-03-05-88` creates anchor `#finding-2026-03-05-88`)

**MUST NOT:**
- Skip creating this document
- Use vague verification descriptions
- Omit source quotes or evidence

---

## Output

**Creates:**
- `.memory/{basename}-verification-working.md` with detailed verification evidence

**Next step:** [Create Archive](create-archive.md)
