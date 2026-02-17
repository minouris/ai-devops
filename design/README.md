# Design Documentation

This directory contains human-readable design documentation created during the design phase of the project.

## Purpose

Design documents facilitate:
- Team collaboration and decision-making
- Communication between stakeholders
- Reference documentation for future maintainers
- Rationale capture for design decisions

## What Belongs Here

- Problem definitions and analysis
- Requirements specifications
- System architecture descriptions
- Component designs
- Feature specifications
- Design decision records

## What Does Not Belong Here

Design documents are **NOT** AI execution instructions. For AI-consumable implementation plans, see the `plans/` directory.

## Writing Style

Design documents use:
- Descriptive prose for human readers
- Third-person or neutral voice
- Rationale explanations and trade-offs
- Context and background information

Design documents do **NOT** use:
- Imperative mood addressing an AI
- Step-by-step execution instructions
- Embedded anti-hallucination directives

## Relationship to Plans

**Design documents** describe what to build and why (human decision-making).

**Plan files** (`plans/` directory) describe how to build it (AI execution).

Typical workflow:
1. Create design documents → 2. Review and approve → 3. Create plan files → 4. AI implements

## Rules

Design documents follow the standards defined in `.claude/rules/design-documents.md`.
