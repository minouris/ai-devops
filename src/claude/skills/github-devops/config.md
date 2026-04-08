# GitHub DevOps Configuration

GitHub repository configuration for `github-devops` skill operations.

## Configuration Fields

**repo** (required): GitHub repository in format `owner/repository-name`
- Example: `minouris/ai-devops` (own project)
- Example: `kubernetes/kubernetes` (remote project)

**org** (optional): Organization name for app-level operations

## Configuration Methods

### Method 1: Edit config.md Directly

Update the values below for persistent configuration. Suitable when the skill consistently operates on the same repository.

### Method 2: Parameterized Configuration

When invoking the skill, pass configuration values as parameters to override config.md. Allows the same skill instance to operate on different repositories without editing this file.

### Method 3: Environment-Based Configuration

Configure repository details via environment variables before invoking the skill. The skill reads these to populate repo and org values dynamically.

## Current Configuration

repo: minouris/ai-devops
org: organization-name