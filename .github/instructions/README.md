# AI DevOps Instructions

This directory contains modular instruction files for AI-assisted software development. These instructions are designed to be used with GitHub Copilot and other AI coding assistants to ensure consistent, high-quality output.

## Overview

The instruction system is modular, allowing you to:
- Apply different instructions to different file types
- Reuse instructions across multiple projects
- Maintain a single source of truth for development standards
- Easily update and version your AI instructions

## Instruction Files

### Core Instructions

These instructions apply universally to all development work:

- **[accuracy.instructions.md](./accuracy.instructions.md)** - NO GUESSING POLICY and source citation requirements
- **[communication.instructions.md](./communication.instructions.md)** - Natural language style (UK English, metric units, communication patterns)
- **[code-review-checklist.instructions.md](./code-review-checklist.instructions.md)** - Mandatory pre-commit verification checklist
- **[git-operations.instructions.md](./git-operations.instructions.md)** - Git workflow and CI/CD troubleshooting guidelines

### Workflow Instructions

- **[planning-workflow.instructions.md](./planning-workflow.instructions.md)** - Complete 8-step planning workflow for features and bug fixes

### Additional Instructions (Project-Specific)

Add language-specific or framework-specific instruction files as needed:

- `python.instructions.md` - Python coding standards and best practices
- `javascript.instructions.md` - JavaScript/TypeScript standards
- `go.instructions.md` - Go language guidelines
- etc.

## How to Use

### With GitHub Copilot

1. Add `.github/copilot-instructions.md` to your project root that references these files
2. GitHub Copilot will automatically read and follow these instructions
3. Instructions with `applyTo: "**/*"` apply to all files
4. Instructions with specific paths apply only to matching files

### As a Reference

These files also serve as documentation for:
- Development team onboarding
- Code review standards
- Architecture decisions
- Quality requirements

## Structure

Each instruction file follows this format:

```markdown
---
applyTo: "glob-pattern"
---

# Instruction Title

## Section 1

Instructions here...

## Section 2

More instructions...
```

The `applyTo` frontmatter specifies which files the instructions should be applied to:
- `"**/*"` - All files
- `"src/**/*.py"` - Python files in src/
- `"features/**/*.md"` - Markdown files in features/
- etc.

## Key Principles

### 1. NO GUESSING POLICY

AI assistants must **never guess or make assumptions**. If uncertain, they must:
- Explicitly state they don't know
- Explain what information is needed
- Suggest where to find the information

See [accuracy.instructions.md](./accuracy.instructions.md) for details.

### 2. Modular Design

Instructions are split into focused, single-purpose files that can be:
- Independently versioned
- Selectively applied
- Easily updated
- Reused across projects

### 3. Quality Gates

Instructions establish clear quality standards:
- Code review checklists
- Nesting depth limits
- Naming conventions
- Test requirements

See [code-review-checklist.instructions.md](./code-review-checklist.instructions.md) for details.

### 4. Workflow-Driven

The planning workflow breaks down complex changes into manageable steps:
1. Create plan skeleton
2. Analysis and planning (iterative)
3. Generate test specifications
4. Generate implementation code
5. Generate documentation changes
6. Generate CHANGES section
7. Verify plan readiness
8. Implement from plan

See [planning-workflow.instructions.md](./planning-workflow.instructions.md) for details.

## Benefits

### For Developers

- **Consistency:** AI assistants follow the same standards every time
- **Quality:** Built-in checks prevent common mistakes
- **Speed:** Automated workflows accelerate development
- **Learning:** Instructions serve as onboarding documentation

### For Teams

- **Standards:** Single source of truth for coding standards
- **Review:** Easier code reviews with consistent output
- **Onboarding:** New team members learn from instructions
- **Evolution:** Instructions can be refined based on experience

### For Projects

- **Quality:** Higher code quality through automated checks
- **Documentation:** Self-documenting development process
- **Maintainability:** Consistent patterns across codebase
- **Portability:** Instructions work across projects

## Integration with Other Projects

These instructions are designed to be **the single source of truth** for AI-assisted development across multiple projects.

### Option 1: Git Submodule

```bash
# In your project
git submodule add https://github.com/minouris/ai-devops .ai-devops
ln -s .ai-devops/.github/instructions .github/instructions
```

### Option 2: Direct Symlink (Same Organisation)

```bash
# For projects in the same workspace
ln -s ../ai-devops/.github/instructions .github/instructions
```

### Option 3: Copy with Documentation

```bash
# Copy files and document the source
cp -r ../ai-devops/.github/instructions .github/instructions
echo "Source: https://github.com/minouris/ai-devops" > .github/instructions/SOURCE.md
```

## Contributing

When updating instructions:

1. Test changes in a real project first
2. Document the rationale for changes
3. Update any affected examples or documentation
4. Consider backward compatibility
5. Update version information if applicable

## Source

These instructions were originally developed for the [spafw37](https://github.com/minouris/spafw37) project and have been generalised for reuse across multiple projects.

**Origin:** `minouris/spafw37/.github/instructions/`  
**Adapted:** February 2026  
**Purpose:** Unified AI-assisted DevOps approach

## See Also

- [RESEARCH_AGGREGATION.md](../../RESEARCH_AGGREGATION.md) - Research findings and timeline
- [Prompts Directory](../prompts/) - Workflow prompt files
- [Templates Directory](../templates/) - Document templates
- Main project [README.md](../../README.md)
