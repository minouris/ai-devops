# AI-Assisted SDLC Framework Design

## Table of Contents

- [Overview](#overview)
- [Core Principles](#core-principles)
  - [AI as Assistant, Not Facilitator](#ai-as-assistant-not-facilitator)
  - [Artifact-Based Collaboration](#artifact-based-collaboration)
  - [Scope Flexibility](#scope-flexibility)
- [The Five Modes](#the-five-modes)
  - [Mode 1: Analyst Mode (Business Analyst Persona)](#mode-1-analyst-mode-business-analyst-persona)
  - [Mode 2: Solution Architecture Mode (Architect Persona)](#mode-2-solution-architecture-mode-architect-persona)
  - [Mode 3: Solution Design Mode (Technical Designer/Lead Engineer Persona)](#mode-3-solution-design-mode-technical-designerlead-engineer-persona)
  - [Mode 4: Feature Design Mode (Feature Planner Persona)](#mode-4-feature-design-mode-feature-planner-persona)
  - [Mode 5: Implementation Mode (Developer Persona)](#mode-5-implementation-mode-developer-persona)
- [Mode Transitions and Approval Gates](#mode-transitions-and-approval-gates)
  - [Approval Gate Mechanism](#approval-gate-mechanism)
  - [Mode Transition Flow](#mode-transition-flow)
- [Scope Enforcement](#scope-enforcement)
  - [Tool Restrictions by Mode](#tool-restrictions-by-mode)
  - [Scope Violation Handling](#scope-violation-handling)
- [Artifact Structure and Traceability](#artifact-structure-and-traceability)
  - [Artifact Types](#artifact-types)
  - [Reference Items](#reference-items)
  - [Linking and Traceability](#linking-and-traceability)
- [Multi-User Collaboration](#multi-user-collaboration)
  - [Shared Repository Approach](#shared-repository-approach)
  - [Conflict Resolution](#conflict-resolution)
- [Design Rationale](#design-rationale)
  - [Why Five Distinct Modes?](#why-five-distinct-modes)
  - [Why Approval Gates?](#why-approval-gates)
  - [Why Artifact-Based Handoffs?](#why-artifact-based-handoffs)
  - [Why Strict Scope Boundaries?](#why-strict-scope-boundaries)
- [Implementation Approach](#implementation-approach)
- [Future Considerations](#future-considerations)
  - [Potential Enhancements](#potential-enhancements)
  - [Open Questions](#open-questions)

## Overview

This document describes the design of a five-mode AI-assisted software development lifecycle framework. The framework guides team members from problem definition through implementation, with AI assistance at each phase. Each mode produces documented artifacts for consumption by downstream team members and subsequent modes.

[↑ Back to Top](#table-of-contents)

## Core Principles

### AI as Assistant, Not Facilitator

The framework is built on the foundational principle that AI assists human team members rather than replacing them. The AI never proceeds with implementation until requirements are fully documented and explicitly approved by human users. This ensures human control and decision-making authority throughout the development process.

[↑ Back to Top](#table-of-contents)

### Artifact-Based Collaboration

Multiple team members collaborate using shared repository artifacts. Each phase produces structured documentation that serves as input to the next phase, creating a traceable chain from problem identification through implementation.

[↑ Back to Top](#table-of-contents)

### Scope Flexibility

The framework accommodates projects of varying sizes:
- Large scope: Complete MVP projects with full SDLC phases
- Medium scope: Individual features within existing systems
- Small scope: Bugfixes and minor enhancements

Not every phase is required for every scope, but problem definition is always mandatory, and implementation always requires approved work items.

[↑ Back to Top](#table-of-contents)

## The Five Modes

### Mode 1: Analyst Mode (Business Analyst Persona)

#### Purpose

Define problems, constraints, and requirements from a business perspective.

#### Responsibilities

- Problem identification through structured questioning
- Constraint documentation (business, organisational, resource)
- Solution definition (business approach, not technical architecture)
- Requirements derivation from problems and solutions

#### Input

Business needs, stakeholder descriptions, problem statements from users

#### Output

Problem definitions, constraint documentation, solution descriptions, requirements specifications

#### Boundaries

The analyst mode operates strictly from a business perspective. It does not suggest technical implementations, make architectural decisions, specify technology choices, or define system components. Technical discussions are deferred to downstream modes.

[↑ Back to Top](#table-of-contents)

### Mode 2: Solution Architecture Mode (Architect Persona)

#### Purpose

Design the overall system architecture that addresses all requirements.

#### Responsibilities

- Define high-level system components
- Establish component relationships and boundaries
- Specify data flows and integration points
- Define structures within components
- Document architectural decisions with rationale

#### Input

Requirements from Analyst Mode, constraint documentation, business context

#### Output

System architecture documentation, component definitions, integration architecture, architectural decision records, data flow diagrams, deployment architecture

#### Boundaries

The architecture mode defines system structure but not implementation details. It does not define specific algorithms, select programming languages or frameworks (unless required by constraints), or create detailed technical designs. Implementation-level decisions are handled by downstream modes.

[↑ Back to Top](#table-of-contents)

### Mode 3: Solution Design Mode (Technical Designer/Lead Engineer Persona)

#### Purpose

Make technical decisions and define algorithms within the architecture.

#### Responsibilities

- Select specific technologies, languages, and frameworks
- Define algorithms and data structures
- Specify APIs and interfaces in detail
- Make performance and security design decisions
- Create detailed technical specifications

#### Input

Architecture from Solution Architecture Mode, requirements from Analyst Mode, constraints

#### Output

Technical design documents, API specifications, algorithm definitions, technology selection rationale, data model specifications, security and performance designs

#### Boundaries

The design mode works within the defined architecture. It does not create feature breakdowns, work items, or tickets (that's Feature Design Mode), implement code, or modify the architecture. If architectural changes are needed, they must be requested from Architecture Mode.

[↑ Back to Top](#table-of-contents)

### Mode 4: Feature Design Mode (Feature Planner Persona)

#### Purpose

Break the solution into implementable features, tasks, and work items.

#### Responsibilities

- Identify implementable features from designs
- Break features into discrete tasks
- Define task dependencies
- Create work items/tickets with acceptance criteria
- Estimate effort and sequence work

#### Input

Technical designs from Solution Design Mode, architecture from Solution Architecture Mode, requirements from Analyst Mode

#### Output

Feature definitions, task breakdowns, work items/tickets (Azure DevOps or equivalent format), dependency graphs, implementation sequence

#### Boundaries

The feature design mode creates work items but does not implement them. It does not write code, make architectural changes, or modify technical designs. Its sole responsibility is breaking approved designs into executable work units.

[↑ Back to Top](#table-of-contents)

### Mode 5: Implementation Mode (Developer Persona)

#### Purpose

Execute implementation based on approved work items.

#### Responsibilities

- Write code per work item specifications
- Create tests per acceptance criteria
- Implement features as defined
- Document code and APIs
- Verify implementation meets work item requirements

#### Input

Work items from Feature Design Mode, technical designs from Solution Design Mode, architecture from Solution Architecture Mode, requirements from Analyst Mode

#### Output

Source code, tests, documentation (code comments, API docs), implementation notes, verification results

#### Boundaries

The implementation mode executes approved work items only. It does not implement anything without an approved work item, modify architecture or designs, create new features not in work items, or proceed without explicit implementation approval.

[↑ Back to Top](#table-of-contents)

## Mode Transitions and Approval Gates

### Approval Gate Mechanism

Each mode transition requires explicit human approval of produced artifacts. The AI presents completed work, asks for approval, and waits for explicit confirmation before proceeding. Ambiguous responses trigger re-prompting for clear approval or rejection.

#### Approved Responses

"yes", "approved", "proceed", "looks good", "go ahead"

#### Rejection Responses

"no", "needs changes", "revise", "not yet"

#### Ambiguous Responses

Trigger re-prompt with explicit options

[↑ Back to Top](#table-of-contents)

### Mode Transition Flow

#### 1. Analyst Mode → Solution Architecture Mode

- Analyst produces: Problems, constraints, requirements
- Approval gate: Requirements reviewed and approved
- Handoff: Architecture mode consumes requirements

#### 2. Solution Architecture Mode → Solution Design Mode

- Architecture produces: System components, integration points, ADRs
- Approval gate: Architecture reviewed and approved
- Handoff: Design mode works within architecture

#### 3. Solution Design Mode → Feature Design Mode

- Design produces: Technical specifications, API definitions, algorithms
- Approval gate: Designs reviewed and approved
- Handoff: Feature mode breaks designs into work items

#### 4. Feature Design Mode → Implementation Mode

- Feature produces: Work items with acceptance criteria
- Approval gate: Work items reviewed and approved
- Handoff: Implementation mode executes work items

#### 5. Implementation Mode → Complete

- Implementation produces: Code, tests, documentation
- Verification: Acceptance criteria met
- Handoff: Deliverables reviewed and accepted

[↑ Back to Top](#table-of-contents)

## Scope Enforcement

### Tool Restrictions by Mode

Each mode has access only to tools appropriate for its phase:

#### Analyst Mode

- Allowed: Question asking, reading existing documents, writing analysis artifacts
- Prohibited: Code editing, implementation commands, detailed design

#### Solution Architecture Mode

- Allowed: Question asking, reading documents, writing architecture artifacts, diagram generation
- Prohibited: Code editing, implementation commands, feature breakdown

#### Solution Design Mode

- Allowed: Question asking, reading documents, writing design artifacts, API definitions
- Prohibited: Code editing, build/deploy commands, work item creation

#### Feature Design Mode

- Allowed: Question asking, reading documents, writing feature/work item artifacts
- Prohibited: Code editing, implementation commands, code generation

#### Implementation Mode

- Allowed: All tools including editing, writing, commands, code generation, testing
- Prohibited: Modifying architecture/design artifacts, creating new requirements

[↑ Back to Top](#table-of-contents)

### Scope Violation Handling

When a mode receives a request outside its scope, it:
1. Politely declines the request
2. Explains why it's outside scope
3. Indicates which mode should handle the request
4. Does not proceed with the out-of-scope operation

[↑ Back to Top](#table-of-contents)

## Artifact Structure and Traceability

### Artifact Types

Each mode produces structured artifacts in standard formats:

#### Problem Definitions

Problem statement, context, symptoms, impact, goals, constraints

#### Requirements

Functional and non-functional requirements with priority and source links

#### Architecture

Component diagrams, interfaces, data flows, architectural decisions

#### Designs

Technical approaches, API specifications, algorithms, data structures

#### Features

Feature descriptions, task breakdowns, work items with acceptance criteria

#### Work Items

Detailed work descriptions, acceptance criteria, verification steps

[↑ Back to Top](#table-of-contents)

### Reference Items

The framework uses a standardized reference system called "Reference Items" for discrete statements within artifacts. Each reference item represents a single fact, problem, solution, constraint, or requirement that can be individually referenced and traced throughout documentation.

#### Identifier Format

Reference items use a consistent identifier format: `PREFIX-N`, `PREFIX-N.N`, or `PREFIX-N.N.N`, where:
- PREFIX is 3-5 uppercase characters identifying the item type (e.g., FACT, PROB, SOLN, CONS, REQ)
- N represents a number at the first level
- Optional additional levels provide hierarchical grouping (maximum 3 levels)

Examples: `FACT-1`, `PROB-2.1`, `REQ-3.2.1`

#### Definition and Reference

Reference items are defined in two-column tables with HTML anchors, allowing them to be linked from anywhere in the documentation. Each item covers one concept in 1-3 sentences. All references to reference items use markdown links to their definitions, creating clickable, verifiable references.

#### Benefits

This standardized approach provides:
- **Unambiguous references**: Each item has a unique identifier that clearly indicates what is being referenced
- **Scriptable validation**: Regular expressions can validate identifier format and link integrity
- **Full traceability**: Track from initial problem through requirements to implementation
- **Impact analysis**: Find all references to specific items when changes occur
- **Hierarchical grouping**: Related items are grouped under common parent numbers (up to 3 levels deep)

[↑ Back to Top](#table-of-contents)

### Linking and Traceability

All artifacts include links to upstream sources using reference item identifiers:
- Requirements link to source problems and constraints (e.g., [PROB-1], [CONS-2])
- Architecture decisions link to requirements addressed (e.g., [REQ-3.1])
- Designs link to architecture components and requirements
- Features link to designs and requirements
- Work items link to features and requirements
- Implementation commits reference work item IDs and reference items

This creates an unbroken chain from initial problem through final implementation, enabling impact analysis and requirement validation. The standardized reference format allows automated validation and traceability reporting.

[↑ Back to Top](#table-of-contents)

## Multi-User Collaboration

### Shared Repository Approach

All artifacts are stored in a version-controlled repository, enabling multiple team members to collaborate:

1. User A (Business Analyst) creates problem definitions and requirements
2. User A commits artifacts to repository
3. User B (Architect) pulls changes and creates architecture
4. User B commits architecture to repository
5. User C (Developer) pulls changes and implements work items
6. User C commits implementation to repository

[↑ Back to Top](#table-of-contents)

### Conflict Resolution

The framework uses git-based conflict resolution:
- One person owns one artifact file at a time
- Parallel work on different features uses branches
- Merge conflicts resolved manually by team
- Artifact IDs are globally unique per project

[↑ Back to Top](#table-of-contents)

## Design Rationale

### Why Five Distinct Modes?

The five-mode structure mirrors traditional software development roles and responsibilities:
- Business Analyst (problems and requirements)
- Architect (system structure)
- Technical Designer (implementation approach)
- Feature Planner (work breakdown)
- Developer (implementation)

This separation ensures appropriate expertise at each phase and prevents premature technical decisions.

[↑ Back to Top](#table-of-contents)

### Why Approval Gates?

Approval gates enforce human control and prevent the AI from making autonomous decisions that should involve human judgment. Each gate ensures work is reviewed before proceeding, maintaining quality and alignment with team goals.

[↑ Back to Top](#table-of-contents)

### Why Artifact-Based Handoffs?

Artifact-based handoffs provide:
- Clear deliverables for each phase
- Persistent documentation of decisions
- Traceability from problem to implementation
- Multi-user collaboration support
- Version control integration

[↑ Back to Top](#table-of-contents)

### Why Strict Scope Boundaries?

Strict scope boundaries prevent:
- Premature technical decisions in early phases
- Scope creep within modes
- AI overstepping its assistance role
- Confusion about which mode handles which concerns

[↑ Back to Top](#table-of-contents)

## Implementation Approach

The framework will be implemented using Claude Code's custom mode feature. Each mode is defined in a `.mode.md` file that specifies:
- Mode name and description
- Persona and constraints
- Input and output artifacts
- Approval gate requirements
- Tool restrictions
- Workflow steps

The modes work together as a cohesive system while maintaining strict boundaries and requiring human approval at each transition.

[↑ Back to Top](#table-of-contents)

## Future Considerations

### Potential Enhancements

#### Problem Classification

Categorise problems to adjust mode behaviour

#### Template Support

Predefined patterns for common domains

#### Automated Validation

Check artifact completeness and linking

#### Metrics Collection

Track mode usage and effectiveness

#### Integration with Project Management

Sync with Azure DevOps, Jira, etc.

[↑ Back to Top](#table-of-contents)

### Open Questions

- How to handle architecture changes discovered during implementation?
- Should there be a feedback loop from implementation to design?
- How to support iterative refinement of requirements?
- What level of detail is appropriate for each artifact type?

These questions will be addressed as the framework is used in practice and evolves based on team feedback.

[↑ Back to Top](#table-of-contents)
