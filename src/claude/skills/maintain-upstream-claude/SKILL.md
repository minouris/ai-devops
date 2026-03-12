---
name: maintain-upstream-claude
description: Synchronise .claude/ with an upstream repository — pull updates, submit local changes as PRs, or report PR review status.
disable-model-invocation: true
allowed-tools: Read, Write, Glob, AskUserQuestion, Bash(${CLAUDE_SKILL_DIR}/scripts/*), Skill
---

# Maintain Upstream .claude

| Action | Purpose |
|--------|---------|
| `update` | Pull latest upstream changes into `.claude/` |
| `submit` | Push local changes upstream as pull requests |
| `check-submission-status` | Report status and review comments on open submit PRs |

Invoke as: `/maintain-upstream-claude <action>`

## Step 1: Read configuration

Read `${CLAUDE_SKILL_DIR}/config.md` and extract `repo` and `branch`. Use these as `$REPO` and `$BRANCH` throughout.

## Step 2: Route to action

Match `$ARGS` to an action file and execute the workflow it contains:

| `$ARGS` | Action file |
|---------|-------------|
| `update` | `${CLAUDE_SKILL_DIR}/actions/update.md` |
| `submit` | `${CLAUDE_SKILL_DIR}/actions/submit.md` |
| `check-submission-status` | `${CLAUDE_SKILL_DIR}/actions/check-submission-status.md` |

If `$ARGS` is empty or does not match any action, list the available actions and stop.

## Working directory

All bash commands run from the **workspace root**. All temporary files are created inside `.tmp/ai-devops-maintain/` — only `.tmp/` needs to be writable for the clone, branch, commit, and push operations.

The only writes outside `.tmp/` are:
- `update` action: syncs files into `.claude/`
- `submit` action: appends to `${CLAUDE_SKILL_DIR}/my-submissions.md`

## MUST

- Read config before routing. Never hardcode `$REPO` or `$BRANCH`.
- Route by reading the action file and executing the workflow it describes.
- Execute init and cleanup scripts at the start and end of each action to manage temporary directories.

## MUST NOT

- Hardcode the repo or branch.
- Leave `.tmp/ai-devops-maintain` behind after completion.
