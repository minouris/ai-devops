# Verification Operation Logging

**This file is loaded when: You need to log verification results.**

---

## Execution

After verification is complete and all findings/terms have been tagged or archived, log the verification operation to the topic log.

---

## Log File Location

```
.memory/[topic]/[topic]-log.md
```

Example:
```
.memory/github-api/github-api-log.md
```

---

## Log Entry Format

```markdown
## LOG-YYYY-MM-DD-N: Verified [N] findings/terms

**Date:** YYYY-MM-DD HH:MM
**Operation:** verify-fact or verify-term
**Verification Type:** fact or term
**Items:** [N] verified, [N] disproven, [N] manual-verification-required

**Files Modified:**
- {fact/term file path}
- {verification working document path}
- {archive file path if applicable}
- {index file path}

**Summary:**
- Newly verified: [Brief list of verified items]
- Disproven/Disputed: [Brief list with reasons if applicable]
- Manual verification required: [List if applicable]
- Verification sources: [List of primary sources checked]

**Verification Working Document:** {path}

**Next Step:** [What should happen next, if relevant]
```

---

## Requirements

**MUST:**
- Log after verification is complete and all files are updated
- Include specific count of verified vs disproven vs manual items
- List all files modified during verification
- Include link to verification working document
- Record sources checked
- Include date and time of verification completion
- Append to log (never overwrite)

**MUST NOT:**
- Log before verification is complete
- Skip logging significant verification operations
- Log incomplete verification results

---

## Log File Creation

If creating log file for first time:

```markdown
# [Topic] Operation Log

**Topic Slug:** [topic]
**Started:** YYYY-MM-DD HH:MM

This log tracks verification and analysis operations for the [topic] topic.

---

[Log entries in chronological order]
```

---

## Output

The verification operation is now logged in the topic log, providing audit trail of when verifications were completed and what was verified.
