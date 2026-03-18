# Action: Create a Pull Request

Create a new pull request on the GitHub repository. This operation uses the REST API to create a PR from a source branch to a target branch.

## Parameters Required

You must obtain these parameters from the user:
- `head`: Branch to merge (e.g., `feature-branch`)
- `base`: Target branch (e.g., `main`)
- `title`: Pull request title
- `body`: Pull request description (optional)

## Verification Steps

Before proceeding to execute the script, you must:
1. Verify all required parameters are provided (head, base, title)
2. Confirm the user has permission to push to the repository

## Execution

Execute the create-pr script (FINDING-2026-03-11-10 verified operation):

```bash
${CLAUDE_SKILL_DIR}/scripts/create-pr.sh "$OWNER" "$REPO" "$head" "$base" "$title" "$body"
```

Where:
- `$OWNER`: Extracted from `$REPO` configuration (owner component)
- `$REPO`: Extracted from `$REPO` configuration (repository name component)
- `$head`: User-provided source branch
- `$base`: User-provided target branch
- `$title`: User-provided PR title
- `$body`: User-provided PR description (empty string if not provided)

## Compliance Gate: Verify Response

After executing the script, you must verify the response before accepting the operation as successful.

**If the script exit code is NOT 0:**
- Report the error message from the script
- Stop execution immediately
- Do not proceed to reporting success

**If the script exit code is 0:**
- Parse the JSON response
- Verify the response contains a `number` field (PR number)
- Verify the response contains a `html_url` field (PR URL)
- Verify the response contains a `state` field with value `"open"`

If any verification fails:
- Report the compliance gate failure
- Stop execution
- Do not accept the operation as complete

## Report Results

If all compliance gates pass, report success including:
- Pull request number (from `number` field)
- Pull request URL (from `html_url` field)
- Source branch (from `head.ref` field)
- Target branch (from `base.ref` field)

## Constraints

**MUST:**
- Use only the create-pr.sh script for PR creation
- Verify response structure before reporting success
- Include the PR number and URL in the success report

**MUST NOT:**
- Retry the operation if it fails
- Assume the PR was created if the response structure is invalid
- Create multiple PRs if the user repeats the request
