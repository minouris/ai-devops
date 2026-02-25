# Branch Creation Phase

You MUST create a properly named git branch now that you know the artifact specifications.

---

## Step 1: Generate Branch Name

**Branch naming convention:**

Format: `ai-artifact/{type}/{name}`

**Examples:**
- `ai-artifact/skill/validator`
- `ai-artifact/agent/analysis`
- `ai-artifact/rule/uk-english`
- `ai-artifact/prompt/commit-message`

**Build branch name from specifications:**
```
branch_name = f"ai-artifact/{artifact_type}/{artifact_name}"
```

---

## Step 2: Create and Switch to Branch

**Create new branch:**

```bash
git checkout -b ai-artifact/{type}/{name}
```

**MUST:**
- Create branch from current HEAD
- Switch to new branch immediately
- Confirm creation success

**Handle errors:**
- If branch already exists: Report "Branch already exists. Delete it first or choose different name."
- If git error: Report error message and halt

---

## Step 3: Confirm Branch Creation

**Report to user:**

```
✓ Created and switched to branch: ai-artifact/{type}/{name}

Artifact specifications:
- Type: {type}
- Platform: {platform}
- Name: {name}

Proceeding to artifact authoring phase...
```

**MUST:**
- Confirm branch name matches artifact specifications
- Show clear success message
- Proceed immediately to artifact authoring phase

**MUST NOT:**
- Create branch before knowing artifact name
- Create branch with incorrect naming convention
- Prompt user for branch name (auto-generate from specifications)
