---
paths:
  - "**/*"
---

# System Operations Standards

## Git-Tracked File Operations

When the current workspace resides in a git repository, you MUST use native git commands for all filesystem operations on version-controlled files instead of native terminal commands.

**MUST:**
- Use `git mv` to move or rename tracked files
- Use `git rm` to delete tracked files
- Use `git rm --cached` to untrack files without deleting them from disk
- Verify the workspace is git-tracked before applying these rules (`git rev-parse --is-inside-work-tree`)

**MUST NOT:**
- Use `mv` to move or rename tracked files
- Use `rm` to delete tracked files
- Use `cp` followed by `rm` as a substitute for `git mv`
- Use native filesystem commands for operations that git has an equivalent for

**When creating new files:**
- Creating files with standard tools (e.g., write/create file operations) is acceptable
- Stage new files explicitly with `git add <file>` after creation

---

## Compliance Verification

**Before performing any filesystem operation on a versioned file:**

Ask yourself:
- [ ] Is the workspace inside a git repository?
- [ ] Does git have a native command for this operation (`git mv`, `git rm`)?
- [ ] Am I using the git command rather than the native terminal equivalent?

**If ANY answer is "No":**
- Do not proceed with the native terminal command
- Use the git equivalent instead
- These are mandatory standards
