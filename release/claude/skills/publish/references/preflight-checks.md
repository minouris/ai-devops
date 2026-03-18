# Pre-flight Checks

Before publishing artifacts, you MUST verify git context and discover artifacts marked for release.

---

## Step 1: Verify Git Context

**Check current branch:**

```bash
git branch --show-current
```

**MUST:**
- Verify branch is NOT `main` or `master`
- If on main/master, report error and halt: "Cannot publish from main/master branch. Create a feature branch first."

**Check for uncommitted changes:**

```bash
git status --short
```

**MUST:**
- Verify working tree is clean
- If uncommitted changes exist, report error and halt: "Uncommitted changes detected. Commit or stash changes before publishing."

**Warn if branch name doesn't suggest AI artifact work:**
- Check if branch name matches pattern: `ai-artifact/`
- If not, warn: "Branch name doesn't follow ai-artifact/ convention. Continue? (yes/no)"

---

## Step 2: Discover Release Artifacts

**Scan src/ for artifacts with release frontmatter:**

Use Grep tool to find files with `release:` in frontmatter:

```
grep -r "release:" src/ --include="*.md"
```

**For each file found:**

1. Read file using Read tool
2. Parse frontmatter YAML
3. Check if `release.publish: true`
4. Extract `release.platforms` list
5. Extract `release.validation` rules list

**Build artifact list:**

```json
[
  {
    "path": "src/claude/skills/example/SKILL.md",
    "platforms": ["claude", "copilot"],
    "validation": ["ai-targeted-language", "uk-english"]
  }
]
```

---

## Step 3: Filter to Current Branch

**Get files modified in current branch:**

```bash
git diff main...HEAD --name-only
```

**Filter artifact list:**
- Keep only artifacts that appear in modified files list
- This ensures you only publish artifacts changed in this branch

**Report to user:**

```
Found N artifacts marked for release in this branch:
1. src/claude/skills/example/SKILL.md → claude, copilot
2. src/base/agents/validator.agent.md → claude, copilot, github
```

**MUST NOT:**
- Publish artifacts not modified in current branch
- Proceed if no artifacts found (report: "No artifacts marked for release in this branch")
