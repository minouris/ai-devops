---
name: submit-claude
description: Submit local .claude/ changes to the upstream repository as a pull request targeting the configured branch.
disable-model-invocation: true
context: fork

allowed-tools:
  - Read
  - Glob
  - AskUserQuestion
  - Bash(mkdir -p .tmp)
  - Bash(rm -rf .tmp/ai-devops-submit)
  - Bash(rmdir --ignore-fail-on-non-empty .tmp)
  - Bash(gh repo clone *)
  - Bash(find .tmp/ai-devops-submit/src/claude *)
  - Bash(find .claude *)
  - Bash(rsync *)
  - Bash(rm -f .tmp/ai-devops-submit/src/claude/*)
  - Bash(git -C .tmp/ai-devops-submit *)
  - Bash(gh pr create *)
  - Bash(date *)
---

# Submit .claude to Upstream

Submit changes from this project's `.claude/` folder to the upstream repository as a pull request.

Files that exist in the upstream's `src/claude/` are updated automatically. Files that exist only locally (not present in the upstream) are confirmed with the user before inclusion.

## Workflow

### Step 1: Read configuration

Read `${CLAUDE_SKILL_DIR}/../update-claude/config.md` and extract:

- `repo` — the GitHub repository in `owner/repo` format
- `branch` — the branch to target with the pull request

Use these values wherever `$REPO` and `$BRANCH` appear in subsequent steps.

### Step 2: Prepare workspace

1. Create `.tmp/` if it does not exist:
   ```
   mkdir -p .tmp
   ```
2. Remove any previous submit clone:
   ```
   rm -rf .tmp/ai-devops-submit
   ```

### Step 3: Clone the upstream repository

Clone the configured branch into `.tmp/ai-devops-submit`:

```
gh repo clone $REPO .tmp/ai-devops-submit -- --branch $BRANCH --single-branch
```

If the clone fails, stop and report the error. Do not proceed to subsequent steps.

### Step 4: Categorise local files

List all files currently in `.claude/` (recursively):

```
find .claude -type f
```

List all files in the clone's `src/claude/` (recursively):

```
find .tmp/ai-devops-submit/src/claude -type f
```

Strip path prefixes (`.claude/` and `src/claude/` respectively) to obtain relative paths for both sets, then classify:

- **Upstream files** — relative path exists in **both** `.claude/` and the clone's `src/claude/`. These will be updated automatically.
- **Local-only files** — relative path exists in `.claude/` but **not** in the clone's `src/claude/`. These require user confirmation.

### Step 5: Query the user about local-only files

If there are local-only files, present them to the user using `AskUserQuestion` with `multiSelect: true`. Ask which local-only files to include in the pull request. Note that files not selected will be excluded from the PR.

If there are no local-only files, skip this step.

### Step 6: Create a submit branch in the clone

Get today's date:

```
date +%Y-%m-%d
```

Create a new branch — named `submit/YYYY-MM-DD` where `YYYY-MM-DD` is today's date — in the clone:

```
git -C .tmp/ai-devops-submit checkout -b submit/YYYY-MM-DD
```

### Step 7: Copy local changes into the clone

rsync all `.claude/` files into `src/claude/` in the clone. This overwrites upstream files and adds all local-only files:

```
rsync -av .claude/ .tmp/ai-devops-submit/src/claude/
```

For each local-only file the user chose **not** to include, remove it from the clone:

```
rm -f .tmp/ai-devops-submit/src/claude/RELATIVE_PATH
```

### Step 8: Check for actual changes

Run `git status` to check whether any files were modified:

```
git -C .tmp/ai-devops-submit status --short
```

If the working tree is clean (no modified, added, or deleted files), there is nothing to submit. Report this to the user, clean up, and stop.

### Step 9: Commit and push

Stage all changes:

```
git -C .tmp/ai-devops-submit add -A
```

Commit with a descriptive message:

```
git -C .tmp/ai-devops-submit commit -m "Update .claude from local workspace (YYYY-MM-DD)"
```

Push the submit branch to the upstream:

```
git -C .tmp/ai-devops-submit push origin submit/YYYY-MM-DD
```

### Step 10: Create the pull request

Build a PR body listing what changed:
- Updated files (upstream files that were overwritten)
- Added files (local-only files approved by user at Step 5)

Create the PR targeting `$BRANCH`:

```
gh pr create \
  --repo $REPO \
  --base $BRANCH \
  --head submit/YYYY-MM-DD \
  --title "Update .claude from local workspace (YYYY-MM-DD)" \
  --body "BODY"
```

Display the PR URL to the user.

### Step 11: Clean up

Remove the temporary clone:

```
rm -rf .tmp/ai-devops-submit
```

Remove `.tmp/` if it is now empty:

```
rmdir --ignore-fail-on-non-empty .tmp
```

### Step 12: Report results

Report:

- Source repository and target branch
- Files updated (upstream files overwritten)
- Files added (local-only files the user approved)
- Files excluded (local-only files the user chose not to include)
- Pull request URL

## MUST

- Read config from `${CLAUDE_SKILL_DIR}/../update-claude/config.md`. Do not hardcode the repo or branch.
- Query the user (Step 5) before including any local-only file — a file whose relative path does not exist in the clone's `src/claude/`.
- Create a new submit branch and open a PR — never push directly to `$BRANCH`.
- Check for actual changes (Step 8) before committing. Stop cleanly if there is nothing to submit.
- Clean up `.tmp/ai-devops-submit` after every run, including after failures.
- Include the resolved `repo` and `branch` values in the final report.

## MUST NOT

- Include local-only files in the PR without explicit user confirmation.
- Push directly to `$BRANCH`.
- Hardcode the repo or branch — always read them from config.
- Leave `.tmp/ai-devops-submit` behind after the skill completes.
- Proceed past Step 3 if the clone fails.
