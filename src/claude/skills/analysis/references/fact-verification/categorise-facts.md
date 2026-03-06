# Categorise Facts

Organise verified facts into accepted, retained, and rejected categories with detailed metadata.

---

## Create Three Lists

### Accepted Facts (for verification working document)

```markdown
## Accepted Fact {N}: {Brief Description}

**Fact:** {Exact factual statement}

**Verification:**
- Source: [{Source Name}]({URL})
- Accessed: YYYY-MM-DD
- Published/Updated: YYYY-MM-DD
- Status: Current and verified

**Citation:** According to the [{Source Name}]({URL}), {fact statement}.
```

When multiple sources were consulted, use the primary or most authoritative URL in the tag. Use a short descriptor such as `research synthesis` when the fact derives from synthesising multiple sources rather than a single verifiable URL.

The verification working document will serve as a comprehensive reference for how each fact was verified, with the verification tag in the fact file linking to the relevant section.

---

### Recently Verified Facts (skipped)

```markdown
## Retained Fact {N}: {Brief Description}

**Fact:** {Exact factual statement}
**Verified:** [VERIFIED on YYYY-MM-DD by {original verifier}]  ← retained, within 30-day window

**Status:** Skipped — verified within the last 30 days. Re-verify after {expiry date}.
```

---

### Rejected Facts

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
```

---

## Output

**Creates:**
- Categorised lists of accepted, retained, and rejected facts
- Metadata for each category (sources, dates, reasons)

**Next step:** [Create Verification Working Document](create-verification-working-document.md)
