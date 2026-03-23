# Update Analysis Index

**This file is loaded when: A finding has been verified and the analysis index needs to be updated to reflect the new verified finding.**

---

## Execution

After verification is complete, update the analysis index to include the newly verified finding. This maintains a complete and current index of all active findings in the topic.

---

## Index File Location

```
.memory/[topic]/[topic]-index.md
```

Example:
```
.memory/github-api/github-api-index.md
```

---

## Index Update Operations

### 1. Add or Update "Last Updated" Timestamp

Update the timestamp at the top of the index:

```markdown
# [Topic] Index

**Last Updated:** YYYY-MM-DD HH:MM
```

### 2. Update Fact Files Section

If this is the first verified finding in this file, add entry to the "Fact Files" section:

```markdown
## Fact Files

- [[topic]-facts.md]([topic]-facts.md) - [Brief description]
  - Last updated: YYYY-MM-DD HH:MM
```

### 3. Update Keywords Index

Add new keywords from the finding to the keyword index files:

**If keyword doesn't exist**: Add new keyword entry with count of 1

**If keyword already exists**: Increment the finding count for that keyword

Keyword index format:
```markdown
- **[keyword]** ([N] findings)
```

### 4. Add to Findings Table

Add finding to the Findings table in alphabetically sorted position (by Name, then Keywords):

```markdown
## Findings

| Finding | Name | Keywords |
|---------|------|----------|
| [FINDING-YYYY-MM-DD-N](#finding-yyyy-mm-dd-n) | Finding Name | keyword1, keyword2, keyword3 |
```

---

## Requirements

**MUST:**
- Update "Last Updated" timestamp
- Add finding to Findings table in correct alphabetical position
- Update keyword counts in keyword index
- Add new keywords if not already present
- Use correct finding anchor format (lowercase, hyphens)
- Update total keyword count if new keywords added
- Preserve existing structure and formatting

**MUST NOT:**
- Leave index out of sync with active findings
- Break existing links or references
- Change keyword counts for other findings
- Remove archived findings from the index
- Update file directly in memory without using Edit tool

---

## Integration with Term Verification

For term verifications using the same topic, also update the term-related index entries if applicable (see term-indexing.md). However, maintain separate fact findings and term indices.

---

## Sorting Rules

**Findings table:**
- Primary sort: Name (alphabetical, case-insensitive)
- Secondary sort: Keywords (alphabetical comparison of keyword strings)
- Finding ID is for reference only, not used for sorting

**Keywords:**
- Sort alphabetically
- Include count of findings using each keyword
- Update counts when findings are added or archived

---

## Output

The analysis index is now updated to reflect the newly verified finding and remains current and navigable.
