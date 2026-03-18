---
name: ai-authoring
description: Create AI artifacts (skills, agents, prompts, rules, commands, hooks) with mandatory compliance validation, git branch management, and proper placement in src/ directory structure
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

# AI Authoring Skill

Create new AI artifacts with mandatory compliance validation, proper git branch management, and structured placement in `src/` directory. Supports skills, agents, prompts, rules, commands, and hooks.

---

# Workflow Overview

When you are invoked (`/author-ai`), execute this workflow:

## Phase 1: Artifact Planning (Before Branch Creation)

See [references/artifact-planning.md](references/artifact-planning.md) for complete instructions.

1. Check git prerequisites
2. Gather artifact specifications (type, platform, name)
3. Validate artifact doesn't already exist

## Phase 2: Branch Creation (Now Knows Name)

See [references/branch-creation.md](references/branch-creation.md) for complete instructions.

1. Create branch with proper name: `ai-artifact/{type}/{name}`
2. Switch to new branch
3. Confirm branch creation to user

## Phase 3: Artifact Authoring

See [references/artifact-authoring.md](references/artifact-authoring.md) for complete instructions.

1. Create directory structure per artifact type
2. Gather additional metadata (description, release settings, platform-specific fields)
3. Guide content creation with AI-targeted language enforcement
4. Guide rule embedding if applicable
5. Commit artifact immediately after creation

## Phase 4: Validation and Iteration

See [references/validation-iteration.md](references/validation-iteration.md) for complete instructions.

1. Invoke validator agent with specified rules
2. Report violations with line numbers
3. Guide user to fix issues
4. Recommit fixes immediately
5. Repeat until validation passes or user accepts violations

## Phase 5: Session Summary

See [references/session-summary.md](references/session-summary.md) for complete instructions.

1. List artifacts created in this branch
2. Show validation status for each
3. Provide next steps (run `/publish` or continue authoring)

---

# Important Notes

**MUST:**
- Determine artifact name BEFORE creating branch
- Create properly named branch: `ai-artifact/{type}/{name}`
- Enforce AI-targeted language interactively during authoring
- Commit after each artifact creation and after each fix
- Validate before completing authoring session
- Guide rule embedding/copying with verbatim copy instructions

**MUST NOT:**
- Create branch before knowing artifact name
- Allow third-person language ("The AI should")
- Allow vague language ("try to", "maybe")
- Skip validation steps
- Create monolithic skill files (use SKILL.md + references/)
