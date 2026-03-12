# Action: submit

Submit local `.claude/` changes to the upstream repository as pull requests.

Updates to existing upstream files and additions of new local-only items are always submitted as **separate pull requests**. If only one category of change exists, one PR is created; if both exist, two PRs are created.

`$REPO` and `$BRANCH` are already set by the routing step in SKILL.md.

## Temporary directory

All temporary work uses the workspace `.tmp/` directory (not system `/tmp`). The skill creates `.tmp/ai-devops-maintain/` for cloning and syncing, and cleans it up after completion.

## my-submissions.md

After each PR is created, record it in `${CLAUDE_SKILL_DIR}/my-submissions.md`. `${CLAUDE_SKILL_DIR}` is the skill root (the directory containing `SKILL.md`), **not** the `actions/` subfolder. This file is gitignored (local-only) and is used by the `check-submission-status` action to find your submissions without querying GitHub.

**Format:**

```markdown
# My Submissions

| Date | Branch | PR URL |
|------|--------|--------|
| YYYY-MM-DD | submit/YYYY-MM-DD/updates | https://github.com/REPO/pull/N |
```

**To append a row**: Read the current file. If it does not exist, start from the header above. Add the new row at the end of the table and write the full file back using the `Write` tool.

## Step 1: Initialize temporary directory

```
${CLAUDE_SKILL_DIR}/scripts/init.sh
```

## Step 2: Clone upstream

Execute the clone-and-sync script:

```
${CLAUDE_SKILL_DIR}/scripts/clone-and-sync.sh $REPO $BRANCH .tmp/ai-devops-maintain src/claude/ src/claude/
```

This clones the upstream repository. Note: this time we sync to `src/claude/` in the clone, not to `.claude/`, because we'll be modifying the clone and syncing back to upstream.

If the script exits with a non-zero code, run cleanup and stop. Do not proceed.

## Step 3: Categorise local files

Execute the categorize-files script to get the classification:

```
${CLAUDE_SKILL_DIR}/scripts/categorize-files.sh .claude/ .tmp/ai-devops-maintain/src/claude/
```

Parse the output to build:
- **upstream-modified** set — relative path exists in **both** `.claude/` and upstream
- **local-only** set — relative path exists in `.claude/` only

The script outputs lines in format: `CATEGORY|RELATIVE_PATH`

## Step 4: Group local-only items

Group local-only files by their top-level path component under `.claude/`. All files matching `skills/my-skill/*` form one item: `skills/my-skill`. A file with no parent subdirectory (e.g., `settings.json`) is its own item.

Do not present individual files within a group — present the group.

## Step 5: Query the user about local-only items

If there are local-only items, present each top-level group using `AskUserQuestion` with `multiSelect: true`. For each option include the item path and a count of files it contains.

**AskUserQuestion accepts a maximum of 4 options per question.** If there are more than 4 groups, split across multiple questions, noting in each how many groups remain.

If there are no local-only items, skip this step.

## Step 6: Expand and scan approved items

For each approved item:

1. **Expand to candidate files**: collect all files recursively under the item's path in `.claude/`.

2. **Filter gitignored files**: pass candidate file paths to the filter-ignored script:
   ```
   cat file_list.txt | ${CLAUDE_SKILL_DIR}/scripts/filter-ignored.sh
   ```
   Exclude any path the script reports as ignored.

3. **Scan for sensitive information**: run the scan-sensitive script on all remaining files:
   ```
   ${CLAUDE_SKILL_DIR}/scripts/scan-sensitive.sh FILE1 FILE2 ...
   ```
   The script outputs flagged files with line numbers. Any file listed is **flagged**.

4. If any files are flagged, present them with matching lines to the user via `AskUserQuestion` with `multiSelect: true`. Ask: "The following files contain potentially sensitive patterns. Which should still be included?"
   - Selected files are included despite the flag.
   - Unselected files are excluded.
   - If all files in an approved group are excluded, that group contributes nothing to the PR.

   **AskUserQuestion accepts a maximum of 4 options.** Split across multiple questions if more than 4 files are flagged.

The final set of non-flagged files plus user-confirmed flagged files forms the **additions set**.

## Step 7: Assess what would be submitted

- **updates set**: all upstream-modified files (if any)
- **additions set**: all additions-set files from Step 6 (if any)

If both sets are empty, report "Nothing to submit", run cleanup, and stop.

## Step 8: Get today's date

```
YYYY_MM_DD=$( ${CLAUDE_SKILL_DIR}/scripts/get-date.sh )
```

Use `$YYYY_MM_DD` in all branch names and PR titles in subsequent steps.

## Step 9: Create updates PR (if updates set is non-empty)

1. Create a new branch in the clone:
   ```
   ${CLAUDE_SKILL_DIR}/scripts/git-ops.sh .tmp/ai-devops-maintain checkout -b submit/$YYYY_MM_DD/updates
   ```

2. Sync all `.claude/` files into the clone, then remove every local-only file so only upstream-modified files remain:
   ```
   ${CLAUDE_SKILL_DIR}/scripts/sync-files.sh .claude/ .tmp/ai-devops-maintain/src/claude/
   rm -f .tmp/ai-devops-maintain/src/claude/RELATIVE_PATH   # repeat for each local-only file
   ```

3. Check status:
   ```
   ${CLAUDE_SKILL_DIR}/scripts/git-ops.sh .tmp/ai-devops-maintain status --short
   ```
   If the working tree is clean, skip this PR.

4. Stage, commit, and push:
   ```
   ${CLAUDE_SKILL_DIR}/scripts/git-ops.sh .tmp/ai-devops-maintain add -A
   ${CLAUDE_SKILL_DIR}/scripts/git-ops.sh .tmp/ai-devops-maintain commit -m "Update upstream .claude files ($YYYY_MM_DD)"
   ${CLAUDE_SKILL_DIR}/scripts/git-ops.sh .tmp/ai-devops-maintain push origin submit/$YYYY_MM_DD/updates
   ```

5. Create PR using the github-devops skill:

   Parse owner and repo from `$REPO` (format: "owner/repo"):
   ```
   OWNER="${REPO%%/*}"
   REPO_NAME="${REPO#*/}"
   ```

   Invoke the github-devops skill with the create-pr operation. You must pass the parameters in the format the skill expects:
   ```
   /github-devops create-pr owner=$OWNER repo=$REPO_NAME head=submit/$YYYY_MM_DD/updates base=$BRANCH title="Update .claude: upstream file changes ($YYYY_MM_DD)" body="$BODY"
   ```

   The github-devops skill will create the PR and output the PR URL. Capture this URL for the next step.

6. Record the updates PR URL in `${CLAUDE_SKILL_DIR}/my-submissions.md` (see [my-submissions.md](#my-submissions.md) above).

7. Reset the clone to `$BRANCH` for the next PR:
   ```
   ${CLAUDE_SKILL_DIR}/scripts/git-ops.sh .tmp/ai-devops-maintain checkout $BRANCH
   ```

## Step 10: Create additions PR (if additions set is non-empty)

1. Create a new branch in the clone:
   ```
   ${CLAUDE_SKILL_DIR}/scripts/git-ops.sh .tmp/ai-devops-maintain checkout -b submit/$YYYY_MM_DD/additions
   ```

2. Copy only the approved additions files using `rsync --relative`:
   ```
   ${CLAUDE_SKILL_DIR}/scripts/sync-files.sh ".claude/./RELATIVE_PATH" .tmp/ai-devops-maintain/src/claude/ --relative
   # repeat for each file in the additions set
   ```
   Do not copy upstream-modified files; they belong to the updates PR.

3. Check status:
   ```
   ${CLAUDE_SKILL_DIR}/scripts/git-ops.sh .tmp/ai-devops-maintain status --short
   ```
   If the working tree is clean, skip this PR.

4. Stage, commit, and push:
   ```
   ${CLAUDE_SKILL_DIR}/scripts/git-ops.sh .tmp/ai-devops-maintain add -A
   ${CLAUDE_SKILL_DIR}/scripts/git-ops.sh .tmp/ai-devops-maintain commit -m "Add new .claude items ($YYYY_MM_DD)"
   ${CLAUDE_SKILL_DIR}/scripts/git-ops.sh .tmp/ai-devops-maintain push origin submit/$YYYY_MM_DD/additions
   ```

5. Create PR using the github-devops skill:

   Parse owner and repo from `$REPO` (format: "owner/repo"):
   ```
   OWNER="${REPO%%/*}"
   REPO_NAME="${REPO#*/}"
   ```

   Invoke the github-devops skill with the create-pr operation. You must pass the parameters in the format the skill expects:
   ```
   /github-devops create-pr owner=$OWNER repo=$REPO_NAME head=submit/$YYYY_MM_DD/additions base=$BRANCH title="Add new .claude items ($YYYY_MM_DD)" body="$BODY"
   ```

   The github-devops skill will create the PR and output the PR URL. Capture this URL for the next step.

6. Record the additions PR URL in `${CLAUDE_SKILL_DIR}/my-submissions.md` (see [my-submissions.md](#my-submissions.md) above).

## Step 11: Cleanup

```
${CLAUDE_SKILL_DIR}/scripts/cleanup.sh
```

## Step 12: Report

Report:

- Repository and target branch
- **Updates PR**: files updated, PR URL (or "no updates PR" if skipped)
- **Additions PR**: items added with per-group file counts, PR URL (or "no additions PR" if skipped)
- Items/files excluded — by user choice or sensitive content scan — with reason

## MUST

- Submit upstream-modified files and local-only additions as separate PRs — never mix them in a single PR.
- Group local-only files by top-level item when presenting to the user — never present individual files from within a directory as separate options.
- Filter gitignored files using the filter-ignored script on all expanded candidate files before including them.
- Scan every candidate file for sensitive patterns. Flag any matches and confirm with the user before including.
- Check git status before committing each PR branch. Skip a PR if the working tree is clean.
- Always use `submit/$YYYY_MM_DD/updates` or `submit/$YYYY_MM_DD/additions` branches. Never push directly to `$BRANCH`.
- Run the cleanup script after every run, including after failures (Step 11).
- Execute init script before starting (Step 1).

## MUST NOT

- Mix upstream-modified files and local-only additions in the same PR.
- Include local-only items without explicit user confirmation.
- Include files with sensitive pattern matches without explicit user confirmation.
- Push directly to `$BRANCH`.
- Leave `.tmp/ai-devops-maintain` behind after completion.
- Proceed past Step 2 if the clone fails.
