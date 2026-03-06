# Update Memory File

Rewrite the original memory file with only verified facts and updated verification tags.

---

## Execute

1. Rewrite memory file using Edit or Write tool with ONLY accepted facts
2. Update citations with refreshed URLs and dates
3. Add verification note to file header referencing the verification working document
4. Maintain original file structure where possible

---

## Updated File Header

```markdown
# {File Title}

**Last Verified:** YYYY-MM-DD
**Verification Method:** Source checking via WebFetch/WebSearch
**Verification Details:** See {verification-working-filename}
**Archived Facts:** See {archive filename}

---
```

---

## Updated Fact Format

### Standard fact format:

```markdown
## {Topic}

{Verified fact content}

**Verified:** [VERIFIED on YYYY-MM-DD by {source-url}] ([details]({verification-working-file}#finding-id))
**Source:** [{Source Name}]({URL}) (accessed YYYY-MM-DD, published/updated YYYY-MM-DD)

---
```

### For FINDING-YYYY-MM-DD-N block structure:

Add the `**Verified:**` line to the fact's header block, immediately after the `**Source:**` line:

```markdown
## FINDING-YYYY-MM-DD-N: {Finding Title}

**Source:** {source reference}
**Verified:** [VERIFIED on YYYY-MM-DD by {source-url}] ([details]({verification-working-file}#finding-yyyy-mm-dd-n))
```

---

## Tag Format Explanation

- `{source-url}` — Primary authoritative URL or `research synthesis` for multi-source findings
- `{verification-working-file}` — Path to verification working document (e.g., `.memory/topic-verification-working.md`)
- `#finding-yyyy-mm-dd-n` — Anchor link to the finding's verification section (lowercase, with hyphens)

---

## Important Notes

**MUST:**
- Include ALL accepted facts
- Add `**Verified:** [VERIFIED on YYYY-MM-DD by {source-url}] ([details]({verification-working-file}#finding-id))` to every newly verified fact
- Include link to verification working document in each verification tag
- Preserve existing `**Verified:**` tags on recently verified facts (within 30 days) unchanged
- Use refreshed citations with dates
- Maintain logical organisation
- Note existence of archive file and verification working document
- Preserve any non-factual content (structure, notes, TODOs)

**MUST NOT:**
- Include rejected facts in updated file
- Use old citations without verification
- Remove structural elements (headers, sections)
- Change fact statements beyond verification updates
- Remove or overwrite existing `**Verified:**` tags on retained (skipped) facts
- Omit the link to the verification working document in new verification tags

---

## Output

**Updates:**
- Original memory file with verified facts only
- All newly verified facts tagged with verification links

**Next step:** [Log Progress](log-progress.md)
