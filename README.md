# AI-DevOps

Unified approach to AI-assisted software development and DevOps, aggregating research and best practices from multiple projects.

## Purpose

This project consolidates instruction files, prompts, and workflows for AI-assisted development from several mature projects:
- minouris/spafw37 (most comprehensive workflow)
- minouris/prompt-driven-development (metaprompts and composition)
- minouris/claude-code-container (most up-to-date instructions)
- minouris/nightingale-truenas (memory-based approach)

## Quick Start

1. **Read the Analysis**: [ANALYSIS.md](ANALYSIS.md) contains a comprehensive analysis of all source projects with timeline, maturity assessment, and key findings.

2. **Review Recommendations**: [RECOMMENDATIONS.md](RECOMMENDATIONS.md) provides the concrete import plan with 6 phases and specific files to copy.

3. **Follow the Import Plan**: Start with Phase 1 (core meta-instructions) and work through successive phases.

## Status

✅ **Completed**: Research and analysis phase (Issue #1)  
🔲 **Next**: Begin Phase 1 imports (core instructions)

## Documentation

- [ANALYSIS.md](ANALYSIS.md) - Full project analysis, timeline, and maturity assessment
- [RECOMMENDATIONS.md](RECOMMENDATIONS.md) - Concrete import plan and implementation guide

## Structure (Planned)

```
ai-devops/
├── .github/
│   ├── copilot-instructions.md
│   ├── instructions/          # How to do things
│   │   ├── core/              # Meta-instructions
│   │   ├── standards/         # Quality standards
│   │   ├── technical/         # Domain-specific
│   │   └── composition/       # Advanced patterns
│   ├── prompts/               # What to do
│   │   ├── planning/
│   │   └── execution/
│   └── agents/                # Specialized AI personas
├── docs/
│   ├── framework/             # System documentation
│   ├── lessons/               # Field lessons
│   └── research/              # Background research
└── README.md
```

## Key Principles

1. **Selective Loading**: Only load instructions relevant to current task
2. **Step-Based Execution**: Break plans into discrete, trackable steps
3. **Memory Management**: Explicit fact tracking and verification
4. **Continuous Refinement**: Field lessons fed back into instructions
5. **Safety First**: Built-in verification and guardrails
6. **Tool-Agnostic Core**: But with tool-specific optimizations available

## Related Projects

- [spafw37](https://github.com/minouris/spafw37) - Most mature workflow (102 issues)
- [prompt-driven-development](https://github.com/minouris/prompt-driven-development) - Metaprompts and composition (80+ issues)
- [claude-code-container](https://github.com/minouris/claude-code-container) - Most up-to-date instructions
- [nightingale-truenas](https://github.com/minouris/nightingale-truenas) - Memory-based approach
- [simbox](https://github.com/minouris/simbox) - Sample outputs

## Contributing

This is a consolidation project. Improvements should generally be:
1. Tested in this project
2. Fed back to source projects as appropriate
3. Documented as field lessons
