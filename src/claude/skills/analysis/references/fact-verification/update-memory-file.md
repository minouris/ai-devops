# Update Memory File with Verification Tag

Add verification tag to this accepted fact in the memory file.

---

## Execute

Update the fact in the original memory file by adding the verification tag.

**Do NOT rewrite the entire file yet** - this will be done in Step 3 (Finalize).

For now, track the verification tag that should be added to this fact.

---

## Verification Tag Format

### For standard fact format:

Add after the fact content:

```markdown
**Verified:** [VERIFIED on YYYY-MM-DD by {source-url}] ([details]({verification-working-file}#finding-id))
```

### For FINDING-YYYY-MM-DD-N block structure:

Add to the fact's header block, immediately after the `**Source:**` line:

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
- Include link to verification working document in the verification tag
- Use the primary authoritative URL that verified this fact
- Use lowercase with hyphens for anchor links
- Track this tag for application during finalization

**MUST NOT:**
- Rewrite the entire memory file yet (wait for Step 3)
- Remove or overwrite existing `**Verified:**` tags on retained (skipped) facts
- Omit the link to the verification working document

---

## Output

**Tracks:**
- Verification tag to be added to this fact during finalization

**Next step:** Process next fact, or if all facts done: [Finalize and Log](finalize-and-log.md)
