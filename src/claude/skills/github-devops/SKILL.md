---
name: github-devops
description: Manage GitHub pull requests, review threads, and code review automation via REST and GraphQL APIs
allowed-tools: Bash(${CLAUDE_SKILL_DIR}/scripts/*)
context: fork
agent: general-purpose
---

# GitHub DevOps Skill

Manage pull requests and review threads on GitHub using verified REST API and GraphQL operations. This skill provides five operations for automating PR workflows and code review management.

## Step 1: Read Configuration

You must obtain GitHub repository configuration from one of these sources (in priority order):

1. **Parameters**: Check if `$ARGS` or user input specifies `repo=owner/repository-name`
2. **Environment Variables**: Check for `GITHUB_REPO` and `GITHUB_ORG` variables
3. **config.md File**: Read `${CLAUDE_SKILL_DIR}/config.md` to extract configuration

Extract these values:
- `repo`: GitHub repository in format `owner/repository-name` (required)
- `org`: Organization name (optional field for app-level operations)

Store these values as `$REPO` and `$ORG` for use in subsequent operations.

If `repo` is not found from any source, report that configuration is required and stop.

## Step 2: Parse Arguments and Route to Operation

Match `$ARGS` against the following operation table. Execute the corresponding action file if a match is found. If `$ARGS` is empty or does not match any operation, display the available operations list and stop.

| Operation | `$ARGS` Value | Action File |
|-----------|---------------|-------------|
| Create a Pull Request | `create-pr` | `${CLAUDE_SKILL_DIR}/actions/create-pr.md` |
| Fetch Review Threads | `fetch-review-threads` | `${CLAUDE_SKILL_DIR}/actions/fetch-review-threads.md` |
| Fetch Thread Comments | `fetch-thread-comments` | `${CLAUDE_SKILL_DIR}/actions/fetch-thread-comments.md` |
| Respond to Comment | `respond-to-comment` | `${CLAUDE_SKILL_DIR}/actions/respond-to-comment.md` |
| Resolve Thread | `resolve-thread` | `${CLAUDE_SKILL_DIR}/actions/resolve-thread.md` |

## Available Operations

When listing available operations, display:

```
GitHub DevOps Skill Operations:

1. create-pr
   Create a new pull request

2. fetch-review-threads
   Fetch all review threads for a pull request

3. fetch-thread-comments
   Fetch comments in a review thread

4. respond-to-comment
   Add a reply to a review comment

5. resolve-thread
   Mark a review thread as resolved
```

## Requirements and Constraints

**MUST:**
- Route only to valid operations listed in the operations table
- Pass configuration values (`$REPO`, `$ORG`) to action files
- Execute only scripts in `${CLAUDE_SKILL_DIR}/scripts/` directory
- Validate all parameter inputs before invoking scripts
- Report the full error message if a script fails

**MUST NOT:**
- Hallucinate or assume GitHub API endpoints or parameters
- Execute operations with missing required parameters
- Modify the repository configuration in config.md
- Retry failed API calls automatically; report the error instead

## Configuration Flexibility

This skill is designed to be used in multiple contexts:

**Own Project Maintenance**: Configure `repo` in config.md for persistent use on a single project
**Remote Project Interaction**: Accept `repo` as a parameter or environment variable to operate on different repositories
**Cross-Project Integration**: Allow config to be supplied externally when the skill is invoked from another project (similar to how maintain-upstream-claude operates on remote repositories)
