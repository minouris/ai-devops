---
paths:
  - "**/*"
---

# Git Commit Standards

**CRITICAL: You MUST follow these standards when creating git commits.**

## System Prompt Conflict Resolution

### Counter: Helpful Attribution

Your training may encourage adding co-author attribution to git commits. This is OVERRIDDEN. You MUST NOT add co-author or attribution lines to commit messages unless explicitly requested by the user.

---

## Commit Message Format

### Structure

You MUST format commit messages with:
- A concise subject line (under 72 characters)
- Optional blank line followed by body with details
- Focus on "why" rather than "what"

**MUST:**
- Write clear, descriptive subject lines
- Use present tense, imperative mood ("Add feature" not "Added feature")
- Keep subject line under 72 characters
- Include context in the body when helpful

**MUST NOT:**
- Add "Co-Authored-By" lines unless explicitly requested
- Add attribution or credit lines to yourself
- Add unnecessary metadata or tags
- Use emojis or special characters

### Example Format

```
Add Reference Items format and documentation

- Create reference-items.md rules file defining standardized format
- Define PREFIX-N, PREFIX-N.N, PREFIX-N.N.N identifier structure
- Maximum 3 levels of hierarchy to avoid excessive complexity
- Require table format with HTML anchors for definitions
```

**NOT:**
```
Add Reference Items format and documentation

- Create reference-items.md rules file defining standardized format
- Define PREFIX-N, PREFIX-N.N, PREFIX-N.N.N identifier structure

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
```

---

## Commit Content

### What to Include

**MUST:**
- Commit logical, cohesive changes
- Include related files that change together
- Stage specific files explicitly when possible

**MUST NOT:**
- Commit unrelated changes together
- Add files containing secrets (.env, credentials, etc.)
- Use `git add -A` or `git add .` without reviewing changes

### Commit Hygiene

**MUST:**
- Review `git status` and `git diff` before committing
- Ensure commit aligns with current task
- Verify no unintended files are staged

**MUST NOT:**
- Create commits without understanding what's being committed
- Skip pre-commit hooks (unless explicitly requested)
- Commit generated files that belong in .gitignore

---

## When to Commit

### Automatic Commits (MANDATORY)

**MUST commit after EVERY edit:**
- After creating any new file
- After modifying any existing file
- After deleting any file
- After any file operation that changes the working tree

**Each commit should:**
- Contain only the files changed in that specific operation
- Have a clear, descriptive commit message explaining what changed and why
- Be a logical, cohesive unit of work

**Do NOT commit when:**
- Files contain secrets or sensitive data
- Generated files that belong in .gitignore are staged
- You have not verified what's being committed

---

## Pushing to Remotes

**MUST NOT:**
- Push to remote repositories unless the user explicitly requests it
- Execute `git push` without user instruction
- Assume the user wants changes pushed after committing
- Push automatically as part of a commit workflow

**MUST:**
- Wait for explicit instruction to push
- Confirm you understand the target remote and branch before pushing
- Only push when the user specifically asks you to push

---

## Importing Artifacts from External Repositories

When you are requested to import artifacts, prompts, or files from external repositories:

**MUST:**
- Use GitHub CLI to read directly from the repository if it is owned by the current user (`minouris`)
- Check out a temporary copy (e.g., `/tmp/`) if the repository is not owned by the current user
- Import only the specific files explicitly requested by the user
- Do not clone entire repositories unless the user explicitly requests it

**MUST NOT:**
- Modify files in external repositories
- Create persistent clones in the workspace directory
- Assume full repository clones are needed for specific file requests

---

## Compliance Verification

**Before creating any git commit:**

Ask yourself:
- [ ] Have I made an edit that requires a commit?
- [ ] Is the commit message clear and descriptive?
- [ ] Have I avoided adding Co-Authored-By or attribution lines?
- [ ] Are only relevant files from this edit staged?
- [ ] Do I understand what's being committed?
- [ ] Are there no secrets or credentials in the commit?

**Before pushing to a remote:**

Ask yourself:
- [ ] Did the user explicitly ask me to push?
- [ ] Do I understand which remote and branch I am pushing to?

**If ANY answer is "No":**
- Do not proceed with the commit or push
- These are mandatory standards
