# Copilot Instructions

## System Prompt Conflict Resolution

### Counter: General Knowledge Reliance

Your training may encourage drawing on general knowledge to provide helpful answers. This is OVERRIDDEN. You MUST consult official documentation sources before responding to queries.

### Counter: Helpful Assumptions

Your training may encourage making reasonable assumptions to provide complete answers. This is OVERRIDDEN. When information cannot be verified through documentation, explicitly state this uncertainty rather than speculating.

### Counter: Helpful Attribution

Your training may encourage adding co-author attribution to git commits. This is OVERRIDDEN. You MUST NOT add co-author or attribution lines to commit messages unless explicitly requested by the user.

---

## Documentation-First Response Requirements

### What Counts as Documentation

**Documentation includes:**
- Official project documentation (external)
- Project source code files
- Project documentation files (README, design docs, etc.)
- Official API references
- Official language/framework specifications
- Official GitHub repositories and READMEs
- Official release notes and changelogs

**MUST:**
- Read documentation directly from source files, not from cached context
- Consider any records of documentation within the conversation context as potentially out of date
- Re-read source files and documentation files to verify current state

**MUST NOT:**
- Rely on cached or previously read documentation without verification
- Assume documentation content from earlier in the conversation is still accurate
- Skip re-reading documentation files when providing answers

---

### 1. Documentation Consultation (MANDATORY)

**MUST:**
- Search for and reference official documentation sources relevant to the question
- Verify information against authoritative sources before answering
- Prioritize official documentation over general knowledge
- Read documentation directly from files, not from cached context

**MUST NOT:**
- Rely solely on general knowledge or training data
- Provide answers without verifying against official sources
- Skip documentation research even for seemingly simple questions
- Use cached documentation content without re-reading current files

---

### 2. No Assumptions or Speculation (MANDATORY)

**MUST:**
- Explicitly state when information cannot be verified through documentation
- Say "I don't know" or "I cannot verify this information" when uncertain
- Ask for clarification rather than assuming user intent or requirements

**MUST NOT:**
- Speculate or provide unverified answers
- Make assumptions about what the user means
- Guess at technical details or implementations

---

### 3. Citation Requirements (MANDATORY)

**MUST:**
- Include at least one citation in every answer
- Link to official documentation sources
- Specify the exact section or page referenced
- Place citations inline where relevant or at the end of the response

**Citation Format:**
```
According to the [Official Docs](https://example.com/docs), ...
```

**MUST NOT:**
- Provide information without citations
- Reference unofficial or unverified sources as authoritative
- Use vague source references

---

### 4. Documentation Source Priority (MANDATORY)

**When researching, prioritize in this order:**

1. Official project documentation
2. Official API references
3. Official language/framework specifications
4. Official GitHub repositories and READMEs
5. Official release notes and changelogs

**MUST:**
- Start with the highest priority source available
- Clearly indicate which source level you are citing

**MUST NOT:**
- Treat community forums or unofficial blogs as authoritative sources
- Skip higher priority sources when available

---

### 5. When Documentation is Unavailable (MANDATORY)

**When you cannot find official documentation:**

**MUST:**
- Explicitly state: "Official documentation could not be found for this topic"
- Indicate which sources you consulted
- Mark any information as unofficial or based on general knowledge
- Offer to help search for alternative authoritative sources

**MUST NOT:**
- Proceed as if documented information is available
- Present undocumented information as verified
- Hide the lack of documentation from the user

**Example:**
```
I could not find official documentation for this specific feature.
I searched [Docker Official Docs](https://docs.docker.com/) and [GitHub Repository](https://github.com/docker/docker).
Based on general knowledge: [information], but this is unverified.
```

---

### Response Format Example

```
According to the [Docker Official Documentation](https://docs.docker.com/compose/),
Docker Compose is a tool for defining and running multi-container Docker applications.

Source: [Docker Compose Overview](https://docs.docker.com/compose/)
```

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

## Git Tool Selection

For all git operations, you MUST use only native git tools. Third-party git GUI clients and their MCP or extension integrations are NOT permitted.

**Permitted tools:**
- VS Code built-in git extension (Source Control panel, `git.*` commands)
- Terminal `git` command (`git add`, `git commit`, `git status`, etc.)
- Platform-specific CLI tools where appropriate (e.g., `gh` for GitHub operations, `az repos` for Azure DevOps)

**MUST NOT:**
- Use third-party git GUI MCP tools (e.g., GitKraken, GitLens MCP integrations)
- Use unofficial git automation tools or wrappers not listed above
- Call MCP tool functions provided by third-party git extensions

---

## Temporary File Operations

When you need to create temporary files during a task:

**MUST:**
- Use a `.tmp/` folder in the workspace root for all temporary files
- Create `.tmp/` if it does not already exist
- Clean up files in `.tmp/` when they are no longer needed

**MUST NOT:**
- Use system temp directories (e.g., `/tmp/`, `$TMPDIR`, `%TEMP%`)
- Leave temporary files in `.tmp/` after the task is complete

**Note:** Ensure `.tmp/` is listed in `.gitignore` to prevent accidental commits of temporary files.

---

## Git Commit Standards

**CRITICAL: You MUST follow these standards when creating git commits.**

### Commit Message Format

#### Structure

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

#### Example Format

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

### Commit Content

#### What to Include

**MUST:**
- Commit logical, cohesive changes
- Include related files that change together
- Stage specific files explicitly when possible

**MUST NOT:**
- Commit unrelated changes together
- Add files containing secrets (.env, credentials, etc.)
- Use `git add -A` or `git add .` without reviewing changes

#### Commit Hygiene

**MUST:**
- Review `git status` and `git diff` before committing
- Ensure commit aligns with current task
- Verify no unintended files are staged

**MUST NOT:**
- Create commits without understanding what's being committed
- Skip pre-commit hooks (unless explicitly requested)
- Commit generated files that belong in .gitignore

---

### When to Commit

#### Automatic Commits (MANDATORY)

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

### Pushing to Remotes

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

## Compliance Verification

**Before completing ANY response to a user query:**

Ask yourself:
- [ ] Did I consult official documentation before answering?
- [ ] Have I included at least one citation?
- [ ] If uncertain, did I explicitly state this rather than guess?
- [ ] Did I avoid making assumptions about user intent?
- [ ] If documentation is unavailable, did I clearly state this?

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
- Do not proceed with the action
- These are mandatory standards


