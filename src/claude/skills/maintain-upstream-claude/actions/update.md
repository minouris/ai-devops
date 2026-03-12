# Action: update

Pull latest upstream changes into `.claude/`. Files that exist in the upstream are overwritten with the latest version. Files present only in `.claude/` (local-only) are left intact.

`$REPO` and `$BRANCH` are already set by the routing step in SKILL.md.

## Initialization and cleanup

The skill uses dedicated init/cleanup scripts to manage the temporary `.tmp/` directory:
- `init.sh` — Creates `.tmp/` directory at start of operation
- `cleanup.sh` — Removes `.tmp/ai-devops-maintain/` and cleans up after operation

## Step 1: Initialize temporary directory

```
${CLAUDE_SKILL_DIR}/scripts/init.sh
```

## Step 2: Execute clone-and-sync script

The clone-and-sync script handles: prepare workspace, clone upstream via git, sync files, and clean up. All operations use `.tmp/` directory for temporary files.

```
${CLAUDE_SKILL_DIR}/scripts/clone-and-sync.sh $REPO $BRANCH .tmp/ai-devops-maintain src/claude/ .claude/
```

If the script exits with a non-zero code, run cleanup and stop. Do not proceed.

Capture the script's stderr output — it contains the list of updated and added files.

## Step 3: Cleanup

```
${CLAUDE_SKILL_DIR}/scripts/cleanup.sh
```

## Step 4: Report

Report:

- Source repository and branch
- Files updated (existed in `.claude/` and were overwritten)
- Files added from upstream (did not previously exist in `.claude/`)
- Count of local-only files left intact (present in `.claude/` but absent in upstream)

## MUST

- Execute the clone-and-sync script. It handles all clone, sync, and cleanup operations.
- Stop immediately if the script exits with non-zero code.
- Parse rsync output in the script's stderr to extract file counts for the report.

## MUST NOT

- Manually run git clone or rsync — only use the script.
- Leave `.tmp/ai-devops-maintain` behind. The script cleans up automatically.

