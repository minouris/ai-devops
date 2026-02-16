# Getting Started with AI DevOps

This guide will help you integrate the AI DevOps approach into your projects.

## What You'll Get

By following this guide, you'll set up:
- ✅ AI instruction files for consistent code quality
- ✅ Structured workflow for feature development
- ✅ Templates for planning and documentation
- ✅ Quality gates and verification checks

## Prerequisites

- Git installed on your machine
- A GitHub repository for your project
- GitHub Copilot or another AI coding assistant
- Basic familiarity with your programming language

## Quick Setup (5 Minutes)

### Option 1: Full Integration (Recommended)

Add this repository as a submodule to get automatic updates:

```bash
# Navigate to your project
cd your-project

# Add ai-devops as a submodule
git submodule add https://github.com/minouris/ai-devops .ai-devops

# Create symlinks to the instruction files
mkdir -p .github
ln -s ../.ai-devops/.github/instructions .github/instructions
ln -s ../.ai-devops/.github/prompts .github/prompts
ln -s ../.ai-devops/.github/templates .github/templates

# Commit the changes
git add .gitmodules .ai-devops .github
git commit -m "Add AI DevOps instruction system"
```

### Option 2: Copy Files

If you prefer to have local copies:

```bash
# Navigate to your project
cd your-project

# Copy the .github directory
mkdir -p .github
cp -r path/to/ai-devops/.github/instructions .github/
cp -r path/to/ai-devops/.github/prompts .github/
cp -r path/to/ai-devops/.github/templates .github/

# Create a source reference
echo "Source: https://github.com/minouris/ai-devops" > .github/instructions/SOURCE.md
echo "Last updated: $(date +%Y-%m-%d)" >> .github/instructions/SOURCE.md

# Commit the changes
git add .github
git commit -m "Add AI DevOps instruction files"
```

## Configure GitHub Copilot

Create `.github/copilot-instructions.md` in your project:

```markdown
# GitHub Copilot Instructions for [Your Project]

## Instruction Files

This project uses modular instruction files from [ai-devops](https://github.com/minouris/ai-devops):

- **`.github/instructions/accuracy.instructions.md`** - NO GUESSING POLICY and source citations
- **`.github/instructions/communication.instructions.md`** - UK English, metric units, communication style
- **`.github/instructions/code-review-checklist.instructions.md`** - Mandatory pre-commit verification
- **`.github/instructions/git-operations.instructions.md`** - Git workflow and CI/CD troubleshooting
- **`.github/instructions/planning-workflow.instructions.md`** - 8-step feature development workflow

## Project Overview

[Add a brief description of your project here]

## Development Environment

[Document setup instructions, dependencies, etc.]

## Project-Specific Guidelines

[Add any project-specific rules or conventions]
```

## Your First Feature with AI DevOps

Let's walk through developing a feature using the planning workflow:

### Step 1: Create an Issue

Create a GitHub issue for your feature:

```
Title: Add user authentication
Body: We need to add basic user authentication with login/logout functionality.
```

Let's say this becomes issue #42.

### Step 2: Create Plan Skeleton

In GitHub Copilot Chat, say:

```
Create the plan skeleton for issue #42
```

This creates a structured plan document with sections for:
- Overview
- Implementation Steps
- Further Considerations
- Success Criteria

### Step 3: Analysis and Planning

Say to Copilot:

```
Do the analysis and planning step for issue #42
```

Copilot will:
- Analyze your codebase
- Identify what needs to change
- Break work into logical steps
- Ask clarification questions

### Step 4: Answer Questions

Copilot may ask questions like:
- "Should we use JWT tokens or session-based auth?"
- "What user information should be stored?"

Answer them:

```
Update the plan with: 
- Use JWT tokens
- Store username, email, and hashed password
```

Repeat until all questions are answered.

### Step 5-7: Generate Artifacts

Continue through the workflow:

```
Generate preliminary test specs for issue #42
Generate implementation code for issue #42
Generate documentation changes for issue #42
Generate CHANGES section for issue #42
Verify the plan is ready for implementation
```

### Step 8: Implement

Finally, implement the actual code:

```
Implement issue #42 from the plan
```

Copilot will:
- Write tests first (TDD)
- Implement the code
- Verify everything passes
- Update documentation

## Key Concepts

### NO GUESSING POLICY

The most important rule: **AI assistants never guess**.

If Copilot doesn't know something, it will:
1. Explicitly state it doesn't know
2. Explain what information is needed
3. Suggest where to find it

This prevents wasted time on incorrect implementations.

### Quality Gates

Built-in checks ensure quality:

- **Nesting depth:** Max 2 levels inside functions
- **Block size:** Max 2 lines in nested blocks
- **Naming:** No single-letter variables
- **Imports:** Always at module level
- **Tests:** Written before implementation

### Modular Instructions

Instructions are split into focused files:

- **accuracy** - NO GUESSING POLICY
- **communication** - Language and style
- **code-review-checklist** - Pre-commit checks
- **git-operations** - CI/CD troubleshooting
- **planning-workflow** - Feature development

This makes them:
- Easy to understand
- Simple to update
- Reusable across projects

## Customization

### Add Language-Specific Instructions

Create `.github/instructions/python.instructions.md`:

```markdown
---
applyTo: "**/*.py"
---

# Python Coding Standards

## Import Organization

1. Standard library imports
2. Third-party imports
3. Local imports

[Add your Python-specific rules]
```

### Override Global Settings

In your `.github/copilot-instructions.md`, you can override any global setting:

```markdown
## Project Overrides

**Nesting depth:** This project allows 3 levels for legacy compatibility
**US English:** This project uses US English for consistency with existing code
```

### Add Project-Specific Workflows

Create custom prompt files in `.github/prompts/`:

```markdown
# Deploy to Production

## Checklist

- [ ] All tests pass
- [ ] Code review approved
- [ ] Documentation updated
- [ ] CHANGELOG updated

## Steps

1. Merge to main
2. Create release tag
3. Deploy to staging
4. Run smoke tests
5. Deploy to production
```

## Troubleshooting

### GitHub Copilot Not Using Instructions

**Problem:** Copilot doesn't seem to follow the instructions.

**Solutions:**
1. Verify files are in `.github/instructions/`
2. Check `copilot-instructions.md` references them
3. Restart VS Code/your editor
4. Explicitly reference instructions: "Following the accuracy instructions, ..."

### Instructions Conflicting

**Problem:** Multiple instructions contradict each other.

**Solutions:**
1. More specific instructions override general ones
2. Use `applyTo:` to limit scope
3. Document overrides in project `copilot-instructions.md`

### Workflow Too Rigid

**Problem:** The 8-step workflow feels like overkill for small changes.

**Solutions:**
1. Use full workflow for complex features only
2. For small changes, skip to Step 8 directly
3. Create a simplified 3-step workflow for your project

### AI Making Wrong Assumptions

**Problem:** AI assumes things about your codebase.

**Solution:** This is exactly what the NO GUESSING POLICY prevents! If it happens:
1. Report it in the issue
2. Update instructions to be more explicit
3. Add project-specific context to `copilot-instructions.md`

## Next Steps

### Learn More

- Read [RESEARCH_AGGREGATION.md](RESEARCH_AGGREGATION.md) for the full story
- Explore [.github/instructions/](.github/instructions/) for all instructions
- Review [.github/prompts/](.github/prompts/) for workflow details

### Contribute

Found ways to improve the system?

1. Test changes in your project
2. Document what works and what doesn't
3. Share findings via issues or pull requests

### Stay Updated

If using the submodule approach:

```bash
# Update to latest version
git submodule update --remote .ai-devops

# Commit the update
git add .ai-devops
git commit -m "Update ai-devops to latest version"
```

## Support

- **GitHub Issues:** Report bugs or suggest improvements
- **Discussions:** Ask questions and share experiences
- **Examples:** Check the `examples/` directory for real-world usage

## Success Indicators

You'll know the system is working when:

- ✅ AI stops guessing and asks for clarification
- ✅ Code quality improves (fewer nested loops, better names)
- ✅ Planning documents capture decisions and rationale
- ✅ Code reviews go faster (consistent patterns)
- ✅ Onboarding is easier (instructions document the process)

## Common Questions

### Q: Do I need to use all instructions?

**A:** No! Start with the core files and add more as needed.

### Q: Can I modify the instructions?

**A:** Yes! They're designed to be customized for your project.

### Q: Will this work with other AI assistants?

**A:** The principles apply broadly, but specific integration depends on the assistant.

### Q: How do I update instructions across multiple projects?

**A:** Use the submodule approach - update once, pull everywhere.

### Q: What if my team doesn't use AI assistants?

**A:** The instructions still work as development documentation!

---

**You're all set!** Start with a small feature to get familiar with the workflow, then scale up to more complex changes.

For detailed workflow information, see [planning-workflow.instructions.md](.github/instructions/planning-workflow.instructions.md).
