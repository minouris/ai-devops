# Create Verification Working Document Entry

Append this fact's verification details to the working document.

---

## Execute

Append to the verification working document created in Step 1 (`{basename}-verification-working.md`).

---

## Format for ACCEPTED Fact

```markdown
## FINDING-YYYY-MM-DD-N: {Finding Title}

**Claim:** {Brief summary of what the finding claims}

**Verification:**

From [Source Name](URL):

> "{Exact quote from source that verifies the claim}"

{Additional quotes or evidence as needed}

**Status:** ✅ VERIFIED - {Summary of verification result}

---
```

---

## Format for REJECTED Fact

```markdown
## FINDING-YYYY-MM-DD-N: {Finding Title}

**Claim:** {Brief summary of what the finding claimed}

**Verification:**

Checked [Source Name](URL):

{What was found or not found}

**Status:** ❌ REJECTED - {Why it was rejected}

**Rejection Reason:** {Specific reason - outdated/inaccurate/unverifiable/superseded}

---
```

---

## Format for PARTIALLY VERIFIED Fact

```markdown
## FINDING-YYYY-MM-DD-N: {Finding Title}

**Claim:** {Brief summary of what the finding claims}

**Verification:**

From [Source Name](URL):

> "{Exact quote from source}"

{What was verified and what wasn't}

**Status:** ⚠️ PARTIALLY VERIFIED - {What was verified, what wasn't}

---
```

---

## Important Notes

**MUST:**
- Include detailed evidence for this fact's verification
- Provide exact quotes from sources where possible
- Document verification status clearly
- Use markdown heading anchors that match the finding identifiers (e.g., `## FINDING-2026-03-05-88` creates anchor `#finding-2026-03-05-88`)
- Append to existing working document (do not overwrite)

**MUST NOT:**
- Skip documenting verification details
- Use vague verification descriptions
- Omit source quotes or evidence

---

## Output

**Updates:**
- Appends this fact's verification details to `.memory/{basename}-verification-working.md`

**Next step:** If ACCEPTED: [Tag in memory file](update-memory-file.md). If REJECTED: [Append to archive](create-archive.md)
