# Recommendations: Import Plan for AI-DevOps Project

## Executive Summary

After examining 5 projects (spafw37, prompt-driven-development, claude-code-container, nightingale-truenas, simbox), we recommend importing artifacts in 7 priority phases focusing on:
1. Latest meta-instructions emphasizing **self-contained step prompts with policy**
2. Proven domain standards from spafw37
3. **Solution-focused** planning workflow (not feature-focused) that avoids context overflow
4. Business analysis documentation structure from simbox
5. SDLC framework support from claude-code-container
6. Composition patterns for future extensibility (fine-grained, not over-engineered)
7. Specialized agents for architecture and design phases

**Key Insights**:
- spafw37's **context overflow** is critical problem: large feature-focused plans push out instructions during Step 8
- nightingale-truenas's discovery: **step files as self-contained prompts with embedded policy**
- simbox's design/architecture/01_requirements shows target business analysis format
- PDD contains valuable research on AI development pitfalls to learn from

See [ANALYSIS.md](ANALYSIS.md) for full details.

## Quick Import Plan

### Phase 1: Foundation (Immediate)
**Source**: claude-code-container, nightingale-truenas  
**Import to**: `.github/instructions/core/`

- `instruction-files.instructions.md` - How to write instruction files
- `prompt-files.instructions.md` - How to write prompt files
- `plan-files.instructions.md` - How to structure plans
- `step-files.instructions.md` - **How to write self-contained step prompts with policy** (key discovery!)
- `markdown-formatting.instructions.md` - Consistent formatting

**Action**: Copy from minouris/claude-code-container/.devcontainer/.github/instructions/ and minouris/nightingale-truenas/.github/instructions/

**Why First**: These meta-instructions define how to create everything else. The step-files approach from nightingale-truenas is the foundation for avoiding spafw37's context overflow problems.

### Phase 2: Standards (Week 1)
**Source**: spafw37  
**Import to**: `.github/instructions/standards/`

- `accuracy.instructions.md`
- `communication.instructions.md`
- `code-review-checklist.instructions.md`

**Action**: Copy from minouris/spafw37/.github/instructions/

### Phase 3: Workflow (Week 2)
**Source**: spafw37 (adapted), nightingale-truenas  
**Import to**: `.github/prompts/planning/` and `.github/prompts/execution/`

**Import and adapt**:
- `1-create-plan-skeleton.md` → `create-plan.prompt.md` (adapt to solution-focus, not feature-focus)
- `7-verify-plan-readiness.md` → `verify-plan.prompt.md`
- `convert-plan-to-steps.prompt.md` (from nightingale-truenas) - **Converts plans to self-contained step prompts**
- `verify-plan-facts.prompt.md` (from nightingale-truenas)

**Do NOT import**:
- `2-analyse-and-plan.md` - Creates too-large plans causing context overflow
- `8-implement-from-plan.md` - Use step-based execution instead
- Steps 3-6 (generate-tests, generate-implementation, etc.) - Too prescriptive

**Also consider**: spafw37 Issue #100 "Change Registry System" for workshopping changes before issue creation

**Action**: Copy and adapt. Change from feature-focus to solution-focus. Remove Python-specific content.

**Why Critical**: Fixes spafw37's core problems while keeping proven workflow structure.

### Phase 4: Business Analysis Format (Week 3)
**Source**: simbox (main branch, NOT master)  
**Import to**: `docs/templates/` as reference

**Review and adapt**:
- `design/architecture/01_requirements/` structure:
  - 01_00_requirements.md (index)
  - 01_01_project_overview.md
  - 01_02_problem_statement.md
  - 01_03_constraints.md
  - 01_04_requirements.md
  - 01_05_traceability.md
  - 01_06_existing_solutions.md
  - 01_07_qa.md

**Action**: Review simbox main branch. Adapt the 7-file structure as template. Page layouts need refinement but structure is target.

**Why Important**: Shows desired output format for business analysis phase of SDLC. Requirements → Business Analysis → Architecture → Design.

### Phase 5: SDLC Framework Support (Week 3-4)
**Source**: claude-code-container  
**Import to**: `.github/instructions/standards/` and `docs/framework/`

- `design-diagrams.instructions.md` - Visual documentation standards
- `design-docs.instructions.md` - Design documentation standards
- `sdlc-framework-design.md` - Overall SDLC framework vision
- `claude_code_custom_modes.md` - Tool-specific optimizations

**Action**: Copy from minouris/claude-code-container

**Why Important**: Supports full SDLC: Requirements → Business Analysis → Architecture → Design → Features → Plans → Steps.

### Phase 6: Composition Patterns (Week 4)
**Source**: prompt-driven-development  
**Import to**: `.github/instructions/composition/`

- `instruction-composition.instructions.md` - How to combine instructions
- `prompt-composition.instructions.md` - How to combine prompts
- `rules.instructions.md` - Guardrail system

**Note**: Keep artifacts fine-grained for future portability, but don't over-engineer modular system now.

**Research Value**: Review PDD issues for research on AI development pitfalls (context windows, system prompts, prompt size).

**Action**: Copy from minouris/prompt-driven-development/.github/instructions/. Review issues for lessons learned.

### Phase 7: Specialized Agents (Future)
**Source**: spafw37  
**Import to**: `.github/agents/`

- `Architecture.agent.md` - System design agent
- `Design.agent.md` - Feature design agent

**Action**: Copy from minouris/spafw37/.github/agents/

**Why Later**: Needed for architecture and design phases, but those aren't defined yet.

## Files NOT to Import

❌ **Critical Avoidance - Causes spafw37's Context Overflow**:
- spafw37's `2-analyse-and-plan.md` - Creates too-large plans
- spafw37's feature-focused approach - Need solution-focused
- spafw37's Steps 3-6 (generate-tests, generate-implementation, etc.) - Too prescriptive
- spafw37's `8-implement-from-plan.md` - Use step-based execution instead
- Automatic instruction loading (PDD) - Causes context issues

❌ **Over-Engineering**:
- PDD's full modular/composition system - Keep fine-grained but don't over-engineer
- PDD security analysis issues - Interesting research but not immediately actionable

❌ **Wrong Scope**:
- Python-specific instructions as-is - Need language-agnostic (but adapt concepts)

## Key Architectural Decisions

### DO:
✅ **Solution-focused not feature-focused**: Address problems and solutions, not just features  
✅ **Step files as self-contained prompts with policy**: Each step includes all necessary context (nightingale-truenas discovery)  
✅ **Selective instruction loading**: Only load relevant to avoid context overflow  
✅ **Memory before plans**: Capture decisions/research explicitly before formal planning (avoid "vibe coding")  
✅ **Keep artifacts fine-grained**: Enable future portability without over-engineering  
✅ **Full SDLC**: Requirements → Business Analysis → Architecture → Design → Features → Plans → Steps  
✅ **Verification built-in**: Fact checking and plan verification  
✅ **Workshop before issues**: Consider Issue #100's Change Registry approach

### DON'T:
❌ **Feature-focused plans**: Causes bloat and context problems  
❌ **Monolithic plans**: Causes context overflow that pushes out instructions during Step 8  
❌ **Automatic instruction loading**: Proven problematic (PDD research)  
❌ **8-step sequential workflow**: Too heavyweight  
❌ **Python-only anything**: Keep language-agnostic  
❌ **Over-engineer composition**: Keep simple, fine-grained but not fully modular yet
❌ Over-engineer composition initially (start simple)

## Critical Issues to Review

Before implementing, review these issues from source projects:

**Must Read**:
1. spafw37 #100 - **Change Registry System** (workshopping changes before issues)
2. spafw37 #68 - **Context overflow problem** (the core problem to avoid)
3. spafw37 #93 - Multi-file plan structure (response to context overflow)
4. PDD #75 - Focused task files vs automatic loading (fundamental decision)
5. spafw37 #95 - Planning workflow refinements (field lessons)

**Nice to Read**:
6. PDD #71 - Change identification schemes
7. PDD #76/#80 - Security considerations
8. spafw37 #70 - Prompt refinement tracking
9. PDD issues generally - Rich research on AI development pitfalls

**Command to view**: `gh issue view <number> -R minouris/<repo>`

## Suggested Directory Structure

```
ai-devops/
├── .github/
│   ├── copilot-instructions.md
│   ├── instructions/
│   │   ├── core/              # Phase 1: Meta-instructions (how to write things)
│   │   ├── standards/         # Phase 2: Quality standards + Phase 5 design docs
│   │   ├── technical/         # Phase 2: git-operations, etc.
│   │   └── composition/       # Phase 6: Advanced patterns
│   ├── prompts/
│   │   ├── planning/          # Phase 3: Solution-focused planning prompts
│   │   └── execution/         # Phase 3: Step-based execution
│   └── agents/                # Phase 7: Architecture & Design agents
├── docs/
│   ├── framework/             # Phase 5: SDLC framework docs
│   ├── templates/             # Phase 4: Business analysis templates (simbox)
│   ├── lessons/               # Ongoing: Field lessons
│   └── research/
│       └── ANALYSIS.md        # This analysis
├── RECOMMENDATIONS.md         # This file
└── README.md
```

## Implementation Commands

### Clone source repositories (for reference):
```bash
cd /tmp
gh repo clone minouris/spafw37
gh repo clone minouris/prompt-driven-development
gh repo clone minouris/claude-code-container
gh repo clone minouris/nightingale-truenas
```

### Phase 1 Example:
```bash
cd /home/ciara/src/ai-devops
mkdir -p .github/instructions/core

# From claude-code-container
gh api repos/minouris/claude-code-container/contents/.devcontainer/.github/instructions/instruction-files.instructions.md \
  --jq '.content' | base64 -d > .github/instructions/core/instruction-files.instructions.md

# Repeat for other core files...
```

### Or use web interface:
Visit each file URL and download manually:
- https://github.com/minouris/claude-code-container/tree/main/.devcontainer/.github/instructions
- https://github.com/minouris/spafw37/tree/main/.github/instructions
- etc.

## Success Criteria

✅ Core meta-instructions imported, especially **step-files as self-contained prompts approach**  
✅ At least one complete workflow tested: Requirements → Plan → Steps → Implementation  
✅ **Solution-focused** (not feature-focused) planning validated  
✅ Domain standards (accuracy, communication, git) in place  
✅ **No context overflow** - instructions stay in context during execution  
✅ Structure supports adding more without context issues (selective loading)  
✅ Field lessons from first project documented  
✅ Can link/adapt instructions into other projects easily  
✅ Business analysis template structure defined

## Risk Mitigation

**Risk**: Context overflow (spafw37's critical failure mode)  
**Mitigation**: 
- Self-contained step prompts with embedded policy (nightingale-truenas approach)
- Selective instruction loading (not automatic)
- Solution-focused plans (smaller than feature-focused)
- Avoid spafw37's `2-analyse-and-plan.md` that creates bloated plans

**Risk**: Feature-focus instead of solution-focus  
**Mitigation**: Actively adapt prompts during Phase 3 to address problems/solutions, not features

**Risk**: Over-engineering (like PDD)  
**Mitigation**: Keep artifacts fine-grained but don't implement full composition system yet (Phase 6 is future)

**Risk**: Outdated instructions  
**Mitigation**: Start from claude-code-container (newest), validate with nightingale-truenas discoveries, adapt proven spafw37 content

**Risk**: Language-specific bias (Python from spafw37)  
**Mitigation**: Review and generalize all content during import, keep language-agnostic

**Risk**: Ignoring research lessons  
**Mitigation**: Review PDD issues during Phase 6 for documented AI development pitfalls

## Timeline Estimate

- **Phase 1**: 2-3 hours (copy and review core instructions, especially step-files approach)
- **Phase 2**: 2-3 hours (copy and adapt standards)
- **Phase 3**: 4-6 hours (copy, adapt workflow - critical to change from feature to solution focus)
- **Phase 4**: 2-3 hours (review simbox structure, create templates)
- **Phase 5**: 2-3 hours (copy SDLC framework docs)
- **Phase 6**: 3-4 hours (copy composition patterns, review PDD research issues)
- **Phase 7**: 1-2 hours (copy agents)

**Total**: ~17-24 hours over 4-6 weeks

**Critical Path**: Phases 1-3 must be done well - they fix spafw37's context overflow issues

## Next Immediate Actions

1. ✅ Complete analysis with corrected understanding (DONE)
2. Create directory structure: `mkdir -p .github/instructions/{core,standards,technical,composition} .github/prompts/{planning,execution} .github/agents docs/{framework,templates,lessons,research}`
3. **Critical Phase 1**: Import core instructions from claude-code-container and nightingale-truenas
   - Focus on understanding `step-files.instructions.md` - this is the key to avoiding context overflow
4. Test step-files approach by writing a simple step prompt using the imported instructions
5. Once Phase 1 validated, proceed to Phase 2 (standards)
6. **Before Phase 3**: Review spafw37 #68, #93, #100 and PDD #75 to understand context overflow problem
7. During Phase 3: Actively adapt workflow from feature-focus to solution-focus

## Resources

- Full Analysis: [ANALYSIS.md](ANALYSIS.md)
- Source Projects: All under github.com/minouris/
- Contact: Based on Issue #1 context, user is actively working on this
