# Artifact Planning Phase

You MUST gather artifact specifications BEFORE creating a git branch.

---

## Step 1: Check Git Prerequisites

**Verify workspace is a git repository:**

```bash
git rev-parse --is-inside-work-tree
```

**If not a git repo:**
- Report error: "Not a git repository. Initialize git first: git init"
- Halt workflow

**Check for uncommitted changes:**

```bash
git status --short
```

**If uncommitted changes exist:**
- Warn: "Uncommitted changes detected. These will remain uncommitted while you author the new artifact."
- Ask: "Continue anyway? (yes/no)"
- If no, halt: "Commit or stash changes, then re-run /author-ai"

**Check current branch:**

```bash
git branch --show-current
```

**Report current branch:**
- "Currently on branch: {branch-name}"
- "New branch will be created for this artifact"

---

## Step 2: Gather Artifact Specifications

**Prompt for artifact type:**

Ask: "What type of artifact? (skill/agent/prompt/rule/command/hook)"

Wait for user response.

**Prompt for platform:**

Ask: "What platform? (claude/copilot/github/base)"

Explain:
- `base`: Shared across all platforms
- `claude`: Claude Code specific
- `copilot`: GitHub Copilot specific
- `github`: GitHub-specific (issues, PRs, etc.)

Wait for user response.

**Prompt for artifact name:**

Ask: "Artifact name? (lowercase, hyphens allowed)"

Provide examples:
- For skills: `validator`, `ai-authoring`, `analysis`
- For agents: `validator`, `analyst`, `reviewer`
- For rules: `uk-english`, `markdown-formatting`
- For prompts: `commit-message`, `pr-description`
- For commands: `author-ai`, `publish`, `review`
- For hooks: `pre-bash`, `post-edit`, `on-stop`

Wait for user response.

**Validate name format:**
- Check lowercase
- Allow hyphens
- Disallow spaces, uppercase, special characters
- If invalid, report error and re-prompt

---

## Step 3: Validate Artifact Doesn't Exist

**Build target path:**

For skills: `src/{platform}/skills/{name}/`
For agents: `src/{platform}/agents/{name}.agent.md`
For rules: `src/{platform}/rules/{name}.md`
For prompts: `src/{platform}/prompts/{name}.prompt.md`
For commands: `src/{platform}/commands/{name}.md`
For hooks: `src/{platform}/hooks/{name}.hook.md`

**Check if path exists:**

```bash
ls src/{platform}/{type}/{name}
```

**If exists:**
- Report: "Artifact already exists at {path}"
- Ask: "Options:
  1. Choose a different name
  2. Overwrite existing artifact (WARNING: will delete existing content)
  3. Abort

  Choose option (1/2/3):"

**Handle user response:**
- Option 1: Return to name prompt
- Option 2: Continue (will overwrite)
- Option 3: Halt workflow

**If doesn't exist:**
- Report: "✓ Name available"
- Proceed to next phase

---

## Output

At end of this phase, you MUST have:
- Artifact type (skill/agent/prompt/rule/command/hook)
- Platform (claude/copilot/github/base)
- Artifact name (validated format, checked availability)

These will be used to create the git branch in next phase.
