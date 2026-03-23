# Update Finding with Verification Tag

**This file is loaded when: A finding has been verified and needs to be tagged in the memory file.**

---

## Execution

After verification is complete and documented in the verification working document, update the original finding in the fact file by adding the verification tag.

**DO NOT rewrite the entire file yet** - only tag this specific finding.

---

## Verification Tag Format

Add immediately after the finding content:

```markdown
**Verified:** [VERIFIED on YYYY-MM-DD by {source-url}] ([details]({verification-working-file}#{finding-anchor}))
```

### Tag Components

- `YYYY-MM-DD` - Date verification was completed
- `{source-url}` - Primary authoritative URL or `research synthesis` for multi-source findings
- `{verification-working-file}` - Path to verification working document
- `{finding-anchor}` - Anchor link to verification section in working document (lowercase with hyphens)

---

## Requirements

**MUST:**
- Include link to verification working document in the verification tag
- Use the primary authoritative URL that verified this fact
- Use lowercase with hyphens for anchor links
- Preserve all other finding content unchanged
- Only tag if verification status is VERIFIED (not DISPROVEN or MANUAL)

**MUST NOT:**
- Rewrite the entire fact file (wait for finalization step)
- Remove or modify existing verification tags on other findings
- Omit the link to the verification working document

---

## Output

Tracks the verification tag to be added to the finding, which will be applied during the finalization step when all post-verification operations are complete.
