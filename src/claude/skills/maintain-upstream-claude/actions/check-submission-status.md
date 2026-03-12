# Action: check-submission-status

Report the status and review comments on submitted PRs.

`$REPO` is already set by the routing step in SKILL.md.

## Step 1: Read submission history

Read `${CLAUDE_SKILL_DIR}/my-submissions.md`. `${CLAUDE_SKILL_DIR}` is the skill root (the directory containing `SKILL.md`), **not** the `actions/` subfolder.

- If the file does not exist or contains no data rows, report "No recorded submissions found — run `/maintain-upstream-claude submit` first" and stop.
- Parse each data row to extract: date, branch, and PR URL. The PR number is the last path segment of the URL (e.g., `.../pull/11` → `11`).
- If exactly one entry exists, use it automatically.
- If multiple entries exist, ask the user which to check using `AskUserQuestion` with the most recent entries first. Present up to 4 options; if there are more than 4 entries, present the 4 most recent. Each option should show the date, branch, and PR URL.

## Step 2: Get PR details and comments

For each selected PR, execute the get-pr-details script:

```
${CLAUDE_SKILL_DIR}/scripts/get-pr-details.sh $REPO PR_NUMBER
```

The script uses curl with token extraction from git credential helper to fetch PR details and comments. Parse the JSON output to extract:
- PR number, title, state, URL
- Review decision (approved, changes_requested, pending, or none)
- Reviews with reviewer names and states
- Inline review comments with file paths and line numbers
- General PR comments

## Step 3: Report

For each selected PR, report:

- **PR title, number, and URL**
- **State**: open / merged / closed
- **Mergeability**: mergeable / conflicting / unknown
- **Review decision**: approved / changes requested / pending / none
- **Reviews**: each reviewer's name, state (APPROVED / CHANGES_REQUESTED / COMMENTED), and review body
- **Inline review comments**: file path, line number, author, comment body
- **General comments**: author, comment body

Format each section with a clear heading. If a section has no entries, state that explicitly rather than omitting the section.

## MUST

- Read PR list from `${CLAUDE_SKILL_DIR}/my-submissions.md`, not from GitHub API.
- State explicitly when a section has no entries — do not silently omit empty sections.
- Use the get-pr-details script to fetch all PR information via REST API with automatic token extraction.

## MUST NOT

- Query GitHub to discover PRs — use only entries recorded in `my-submissions.md`.

