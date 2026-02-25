---
name: publish
description: Publish validated AI artifacts from src/ to release/ with compliance validation, platform-specific transformations, and PR creation for merge to main
disable-model-invocation: true
release:
  publish: true
  platforms: [claude]
  validation:
    - ai-targeted-language
    - documentation-standards
    - markdown-formatting
    - skill-structure
---

# Publish Skill

Publish validated AI artifacts from `src/` to `release/` with compliance validation, platform-specific transformations, and automated PR creation.

---

# Workflow Overview

When you are invoked (`/publish`), execute this workflow:

## Phase 1: Pre-flight Checks

See [references/preflight-checks.md](references/preflight-checks.md) for complete instructions.

1. Verify git context (not on main/master, no uncommitted changes)
2. Discover artifacts marked for release in `src/`
3. Filter to artifacts modified in current branch

## Phase 2: Validation

See [references/validation.md](references/validation.md) for complete instructions.

1. Spawn validator agent for each artifact
2. Collect validation results
3. Report results and ask user to proceed

## Phase 3: Transformation and Publication

See [references/transformation.md](references/transformation.md) for complete instructions.

1. Apply platform-specific transformations
2. Copy validated artifacts to `release/{platform}/`
3. Commit publication changes

## Phase 4: PR Creation

See [references/pr-creation.md](references/pr-creation.md) for complete instructions.

1. Generate PR description with validation report
2. Create PR using `gh` CLI
3. Provide PR URL and next steps to user

---

# Important Notes

**MUST:**
- Only publish artifacts marked with `release.publish: true` in frontmatter
- Validate all artifacts before publication
- Apply transformations per platform requirements
- Create PR automatically after publication
- Never push to git remote (only create PR)

**MUST NOT:**
- Publish artifacts with validation failures (without user approval)
- Skip validation steps
- Modify source files in `src/`
- Push changes without PR
