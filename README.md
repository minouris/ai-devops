# AI DevOps

A unified approach to AI-assisted software development and DevOps automation. This repository aggregates best practices, instruction files, prompts, and workflows for building software with AI assistance.

## What is This?

This repository serves as the **single source of truth** for:
- **Instruction files** - Rules and standards for AI coding assistants
- **Workflow prompts** - Step-by-step guides for feature development
- **Templates** - Standardised document structures
- **Best practices** - Lessons learned from multiple projects

## Quick Start

### Using These Instructions in Your Project

#### Option 1: Git Submodule (Recommended)

```bash
# Add as a submodule
git submodule add https://github.com/minouris/ai-devops .ai-devops

# Create symlinks to use the instructions
ln -s .ai-devops/.github/instructions .github/instructions
ln -s .ai-devops/.github/prompts .github/prompts
ln -s .ai-devops/.github/templates .github/templates
```

#### Option 2: Direct Copy

```bash
# Copy the .github directory
cp -r path/to/ai-devops/.github .github

# Document the source
echo "Source: https://github.com/minouris/ai-devops" > .github/instructions/SOURCE.md
```

#### Option 3: Cherry-Pick Files

Copy only the files you need for your project.

### Creating a GitHub Copilot Configuration

Create `.github/copilot-instructions.md` in your project:

```markdown
# GitHub Copilot Instructions

## Instruction Files

This project uses modular instruction files:

- `.github/instructions/accuracy.instructions.md` - NO GUESSING POLICY
- `.github/instructions/communication.instructions.md` - UK English, metric units
- `.github/instructions/code-review-checklist.instructions.md` - Pre-commit checklist
- `.github/instructions/git-operations.instructions.md` - Git and CI/CD guidelines
- `.github/instructions/planning-workflow.instructions.md` - Planning workflow

## Project-Specific Context

[Add project-specific information here]
```

## What's Included

### 📋 [Instruction Files](.github/instructions/)

Modular instruction files for AI assistants:
- **accuracy.instructions.md** - NO GUESSING POLICY and source citations
- **communication.instructions.md** - Natural language style (UK English)
- **code-review-checklist.instructions.md** - Mandatory pre-commit checks
- **git-operations.instructions.md** - Git and CI/CD troubleshooting
- **planning-workflow.instructions.md** - 8-step feature development workflow

### 🔄 [Workflow Prompts](.github/prompts/)

Step-by-step prompt files for feature development:
1. Create plan skeleton
2. Analysis and planning (iterative with Q&A)
3. Generate test specifications
4. Generate implementation code
5. Generate documentation changes
6. Generate CHANGES section
7. Verify plan readiness
8. Implement from plan

(Prompt files will be added in subsequent commits)

### 📝 [Templates](.github/templates/)

Document templates for:
- Issue planning documents
- CHANGES sections for changelogs
- Feature proposals

(Templates will be added in subsequent commits)

### 📊 [Research Documentation](RESEARCH_AGGREGATION.md)

Comprehensive research findings from multiple projects, including:
- Timeline of development
- Maturity assessment of different approaches
- Recommendations for artifact import
- Lessons learned

## Key Features

### 🚫 NO GUESSING POLICY

AI assistants **never guess** or make assumptions. If uncertain, they:
- Explicitly state they don't know
- Explain what information is needed
- Suggest where to find it

### 📐 Quality Standards

Built-in quality standards for:
- Code complexity (max 2 levels of nesting)
- Naming conventions (no single-letter variables)
- Import organization (module-level only)
- Test coverage (tests alongside code)

### 🔄 Structured Workflows

8-step planning workflow that:
- Breaks complex changes into manageable steps
- Includes quality gates at each step
- Uses TDD approach (tests before implementation)
- Documents decisions and rationale

### 🌍 International Standards

- UK English spelling
- Metric units
- Internationally neutral examples
- No US-centric assumptions

## Benefits

### For Developers

- **Consistency:** AI follows the same standards every time
- **Quality:** Built-in checks prevent common mistakes
- **Speed:** Automated workflows accelerate development
- **Learning:** Instructions serve as documentation

### For Teams

- **Standards:** Single source of truth
- **Review:** Easier code reviews
- **Onboarding:** Self-documenting process
- **Evolution:** Continuously refined

### For Projects

- **Quality:** Higher code quality
- **Maintainability:** Consistent patterns
- **Documentation:** Process is documented
- **Portability:** Works across projects

## Project Background

This repository aggregates research and best practices from multiple projects:

- **minouris/spafw37** ✅ - Most mature approach, production-ready
- **minouris/prompt-driven-development** - Metaprompt research (not yet accessible)
- **minouris/claude-code-container** - Modern devcontainer setup (not yet accessible)
- **minouris/simbox** - Example outputs (not yet accessible)
- **minouris/nightingale-truenas** - TrueNAS DevOps (not yet accessible)

See [RESEARCH_AGGREGATION.md](RESEARCH_AGGREGATION.md) for complete analysis.

## Current Status

### ✅ Completed

- [x] Research aggregation from available projects
- [x] Core instruction files imported and adapted
- [x] Documentation structure created
- [x] README and navigation

### 🚧 In Progress

- [ ] Import workflow prompt files
- [ ] Import document templates  
- [ ] Create example feature plans
- [ ] Add language-specific instructions (Python, JavaScript, Go, etc.)

### 📋 Planned

- [ ] Access and analyze additional repositories
- [ ] Create tutorial videos/guides
- [ ] Develop metrics for effectiveness
- [ ] Build community around approach

## Usage Examples

### Starting a New Feature

```bash
# Step 1: Create the plan skeleton
# Say to GitHub Copilot: "Create the plan skeleton for issue #42"

# Step 2: Do analysis and planning
# "Do the analysis and planning step for issue #42"

# Step 3: Answer any questions iteratively
# "Update the plan with: [your answers]"

# ... continue through steps 4-7 ...

# Step 8: Implement the feature
# "Implement issue #42 from the plan"
```

### Code Review Workflow

```bash
# Before writing any code:
# 1. Read .github/instructions/code-review-checklist.instructions.md
# 2. Write code following the checklist
# 3. Verify compliance before committing
```

## Documentation

- [Research Aggregation](RESEARCH_AGGREGATION.md) - Comprehensive research findings
- [Instructions README](.github/instructions/README.md) - Instruction system overview
- [Planning Workflow](.github/instructions/planning-workflow.instructions.md) - Complete workflow guide

## Contributing

This is an evolving system. Contributions are welcome:

1. Test changes in real projects first
2. Document rationale for changes
3. Update examples and documentation
4. Consider backward compatibility

## License

MIT License - See individual files for specific licenses where applicable.

## Origin

Developed by aggregating best practices from multiple AI-assisted development projects. Primary source: [minouris/spafw37](https://github.com/minouris/spafw37).

**Version:** 1.0  
**Last Updated:** February 2026  
**Status:** Initial release with core artifacts from spafw37
