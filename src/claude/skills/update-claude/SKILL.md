---
name: update-claude
description: Update the .claude folder from a configured upstream repository and branch. Overwrites files that exist in the source; preserves locally-added files.
disable-model-invocation: true
context: fork

allowed-tools:
  - Read
  - Bash(gh repo clone *)
  - Bash(rsync *)
  - Bash(rm -rf .tmp/ai-devops-update)
  - Bash(rmdir --ignore-fail-on-non-empty .tmp)
  - Bash(mkdir -p .tmp)
  - Glob
---

# Update .claude from Source

Update this project's `.claude/` folder from a configured upstream repository and branch.

Files that exist in the source are overwritten with the latest version. Files present in `.claude/` that have no counterpart in the source are left intact.

## Workflow

### Step 1: Read configuration

Read `${CLAUDE_SKILL_DIR}/config.md` and extract the values for:

- `repo` — the GitHub repository in `owner/repo` format
- `branch` — the branch to clone

Use these values in all subsequent steps wherever `$REPO` and `$BRANCH` appear.

### Step 2: Prepare workspace

1. Create `.tmp/` if it does not exist:
   ```
   mkdir -p .tmp
   ```
2. Remove any previous update clone to ensure a clean state:
   ```
   rm -rf .tmp/ai-devops-update
   ```

### Step 3: Clone the source repository

Clone the configured branch of the configured repository into `.tmp/ai-devops-update`:

```
gh repo clone $REPO .tmp/ai-devops-update -- --branch $BRANCH --single-branch
```

If the clone fails, stop and report the error. Do not proceed to subsequent steps.

### Step 4: Copy updated files into .claude

Run rsync to copy from the source into `.claude/`. Do not use `--delete`; omitting it preserves files in `.claude/` that have no counterpart in the source.

```
rsync -av .tmp/ai-devops-update/src/claude/ .claude/
```

Capture the rsync output — you will need it for the report in Step 6.

### Step 5: Clean up

Remove the temporary clone:

```
rm -rf .tmp/ai-devops-update
```

Remove `.tmp/` if it is now empty:

```
rmdir --ignore-fail-on-non-empty .tmp
```

### Step 6: Report results

Report the following to the user:

- Source used (`repo` and `branch` from config)
- Files updated (already existed in `.claude/` and were overwritten)
- Files added from source (did not previously exist in `.claude/`)
- Count of files left intact (exist only in `.claude/`, not in the source)

Derive the "left intact" count by comparing the rsync output against the full list of files currently in `.claude/` using Glob.

## MUST

- Read `${CLAUDE_SKILL_DIR}/config.md` before running any other step. Do not use hardcoded repo or branch values.
- Omit `--delete` from the rsync command. Omitting it is what preserves locally-added files.
- Stop and report immediately if the `gh repo clone` command fails.
- Clean up `.tmp/ai-devops-update` after every run, including after failures.
- Include the resolved `repo` and `branch` values in the report.

## MUST NOT

- Hardcode the repo or branch — always read them from `${CLAUDE_SKILL_DIR}/config.md`.
- Add `--delete` or `--delete-after` to the rsync command.
- Commit or push any changes — this skill updates files on disk only.
- Leave `.tmp/ai-devops-update` behind after the skill completes.
- Proceed past Step 3 if the clone fails.
