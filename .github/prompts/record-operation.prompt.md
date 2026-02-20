---
description: "Append a compact record of the latest AI operation to a rolling topic log in .memory/"
name: "record-operation"
argument-hint: "topic=ai-problems-analysis"
tools: ["read_file", "create_file", "replace_string_in_file"]
---

# Record Operation to Topic Log

Append a compact record of the most recent AI operation to `.memory/[topic]-log.md`.

## Input

**Required:**
- `topic` — the current research or work topic (e.g., `ai-problems-analysis`, `chatmodes-skills`). Used to name the log file: `.memory/[topic]-log.md`

---

## What to Record

Extract only what is directly relevant to the operation just completed. Do NOT review the entire session context.

**MUST Include:**
- Timestamp (YYYY-MM-DD HH:MM)
- Operation type (e.g., `Research`, `Fact capture`, `Archive`, `Verification`, `Output draft`, `Output published`)
- Files created or modified (paths only, no content)
- Findings, decisions, or conclusions reached
- Commands run and their outcomes (one line each)
- Issues encountered and confirmed workarounds
- Immediate next step (if known)

**MUST NOT Include:**
- Speculation or unconfirmed theories
- Verbose reasoning or explanation
- Large code blocks (reference file paths instead)
- Information from earlier operations already recorded in the log
- Duplicate entries

---

## Log File

- **Location:** `.memory/[topic]-log.md`
- **Behaviour:** Append-only. Create the file if it does not exist. Never overwrite or remove earlier entries.
- **Order:** Newest entries at the bottom.

---

## Entry Format

```markdown
---

### YYYY-MM-DD HH:MM — [Operation Type]

**Files changed:**
- `.memory/[file]` — [one-line purpose]

**Findings / decisions:**
- [Concise fact or decision]

**Commands:**
- `[command]` — [outcome]

**Issues:**
- [Issue]: [Workaround]

**Next:** [Immediate next step, or "None"]
```

Omit any section that has nothing to record for this operation.

---

## Execution

When invoked with a `topic`:

1. Read `.memory/[topic]-log.md` if it exists (to avoid duplicating the last entry)
2. Extract relevant data from the most recent AI operation in the current context
3. Format as a single entry using the structure above
4. Append the entry to `.memory/[topic]-log.md`, creating the file if needed
5. Confirm: "Operation recorded to `.memory/[topic]-log.md`"
