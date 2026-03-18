# Verification Standards

Reference standards for evaluating source currency, authority, completeness, and accuracy.

---

## Currency

**For API docs:** Within 1 year is current
**For stable specs:** 2-3 years acceptable

---

## Authority (highest to lowest)

1. Official project documentation
2. Official API references
3. Official GitHub repositories and release notes
4. Official blog posts and announcements
5. [Conditional] Community forums, Stack Overflow, unofficial blogs

---

## Community Source Requirements

Community sources (forums, Stack Overflow, unofficial blogs) MAY be used if ALL conditions are met:
- Supporting evidence suggests the information is correct
- Information is explicitly marked as from community sources
- Verification status clearly indicates community source origin
- Flagged for user review acceptance before final acceptance

### Verification tag format for community sources

```markdown
**Verified:** [COMMUNITY SOURCE - REQUIRES USER REVIEW on YYYY-MM-DD from {source-url}] ([details]({verification-working-file}#finding-id))
```

### Important Notes

**MUST:**
- Mark community source facts with `[COMMUNITY SOURCE - REQUIRES USER REVIEW ...]` tag
- Document supporting evidence in verification working document
- Present community-sourced findings to user for explicit acceptance
- Note in verification working document why no official source was available

**MUST NOT:**
- Use community sources when official sources exist
- Accept community sources without supporting evidence
- Mark community-sourced facts as fully verified without user review
- Proceed with community sources as authoritative without explicit user acceptance

---

## Completeness

Citation must include URL, source name, and date accessed.

---

## Accuracy

Fact statement must match source content exactly.
