# Claude Code Custom Modes

## Table of Contents

- [Overview](#overview)
- [Built-in Modes](#built-in-modes)
  - [Default Mode](#default-mode)
  - [Auto Mode](#auto-mode)
  - [Plan Mode](#plan-mode)
- [Creating Custom Modes with Claude Agent SDK](#creating-custom-modes-with-claude-agent-sdk)
  - [Permission Modes](#permission-modes)
  - [Tool Restrictions](#tool-restrictions)
  - [Dynamic Mode Changes](#dynamic-mode-changes)
- [Implementing Custom Modes](#implementing-custom-modes)
  - [Basic Structure](#basic-structure)
  - [Persona-Based Modes](#persona-based-modes)
  - [Workflow-Enforcement Modes](#workflow-enforcement-modes)
- [Mode Implementation Patterns](#mode-implementation-patterns)
  - [Constraint-Based Pattern](#constraint-based-pattern)
  - [Persona-Based Pattern](#persona-based-pattern)
  - [Autonomous Execution Pattern](#autonomous-execution-pattern)
- [Integration with Claude Code CLI](#integration-with-claude-code-cli)
  - [Subagents](#subagents)
  - [Skills and Custom Commands](#skills-and-custom-commands)
- [Practical Implementation Guide](#practical-implementation-guide)
  - [File Structure](#file-structure)
  - [Step-by-Step: Creating a Basic Mode](#step-by-step-creating-a-basic-mode)
  - [Advanced: Mode with Embedded Rules](#advanced-mode-with-embedded-rules)
  - [Directory Structure Best Practices](#directory-structure-best-practices)
  - [Mode Invocation Patterns](#mode-invocation-patterns)
- [Workflow Integration](#workflow-integration)
- [Implementation Guidelines](#implementation-guidelines)
  - [Define Clear Constraints](#define-clear-constraints)
  - [Document Exit Criteria](#document-exit-criteria)
  - [Embed Relevant Rules](#embed-relevant-rules)
  - [Manage Context Budget](#manage-context-budget)
- [Limitations and Considerations](#limitations-and-considerations)
  - [Platform-Level Features](#platform-level-features)
  - [Tool Restriction Scope](#tool-restriction-scope)
  - [State Management](#state-management)
  - [Transition Mechanisms](#transition-mechanisms)
- [Official Documentation Sources](#official-documentation-sources)
- [Complete Example: Problem Definition Mode](#complete-example-problem-definition-mode)
- [Notes](#notes)

---

## Overview

Custom modes in Claude Code are behavioural states that modify how Claude operates during conversations. According to the [Claude Agent SDK documentation](https://platform.claude.com/docs/en/agent-sdk/permissions), modes control tool access and operational constraints through permission modes and tool restrictions.

[↑ Back to top](#table-of-contents)

---

## Built-in Modes

Claude Code provides three built-in interaction modes, as documented in [ClaudeLog](https://claudelog.com/mechanics/plan-mode/) and the [Claude Code common workflows guide](https://code.claude.com/docs/en/common-workflows):

### Default Mode

Claude suggests changes and waits for user permission before executing operations. All tools require permission callback approval.

### Auto Mode

Claude works autonomously, auto-approving file operations without prompting. Other tools still require normal permissions.

### Plan Mode

Claude creates plans using read-only operations only. According to [ClaudeLog's plan mode documentation](https://claudelog.com/mechanics/plan-mode/), plan mode:
- Restricts Claude to analysis and planning without implementation
- Provides access to read-only tools: Read, LS, Glob, Grep, Task research agents, WebFetch, WebSearch
- Prevents Write, Edit, and execution operations
- Produces plan documents as artefacts

Users cycle through modes using Shift+Tab in the Claude Code CLI interface.

[↑ Back to top](#table-of-contents)

---

## Creating Custom Modes with Claude Agent SDK

The [Claude Agent SDK](https://platform.claude.com/docs/en/agent-sdk/overview) enables creation of custom agents with specific behavioural states through permission modes and tool restrictions.

### Permission Modes

According to the [permission configuration documentation](https://platform.claude.com/docs/en/agent-sdk/permissions), the SDK supports several permission modes that control agent behaviour:

#### `default` Mode

All tools require permission callback approval. Standard interactive behaviour.

#### `acceptEdits` Mode

Auto-approves file operations (Write, Edit) whilst other tools require permission. Useful for autonomous code modification with oversight on other operations.

#### `plan` Mode

Prevents tool execution entirely. Agent can analyse code and create plans but cannot make changes. May use AskUserQuestion to clarify requirements. Equivalent to Claude Code's built-in plan mode.

#### `bypassPermissions` Mode

Auto-approves all tool uses without prompts. Hooks still execute and can block operations. Use with extreme caution.

#### `delegate` and `dont_ask` Modes

Delegate tool execution to SDK or proceed without callback prompts. Alternative permission strategies for specific workflows.

### Tool Restrictions

According to the [subagents documentation](https://code.claude.com/docs/en/sub-agents), tool access can be controlled through:

**Allowlist Approach:**
```typescript
{
  tools: ["Read", "Grep", "WebFetch", "WebSearch"]
}
```

Specifies which tools the agent can access. All other tools are unavailable.

**Denylist Approach:**
```typescript
{
  disallowedTools: ["Write", "Edit", "Bash"]
}
```

Specifies which tools the agent cannot access. All other tools remain available.

**Default Behaviour:**
Agents inherit all tools from the main conversation unless restrictions are specified.

### Dynamic Mode Changes

The [Agent SDK overview](https://platform.claude.com/docs/en/agent-sdk/overview) confirms permission modes can be:
- Set once when starting a query
- Changed dynamically whilst the session is active

This enables transitioning between behavioural states during execution.

[↑ Back to top](#table-of-contents)

---

## Implementing Custom Modes

### Basic Structure

Create custom agents with specific permission modes and tool restrictions using the Claude Agent SDK.

**Example: Analysis-Only Mode**
```typescript
{
  permissionMode: "plan",
  tools: ["Read", "Grep", "Glob", "WebFetch", "WebSearch"]
}
```

**Example: Safe Editing Mode**
```typescript
{
  permissionMode: "acceptEdits",
  disallowedTools: ["Bash", "BashInteractive"]
}
```

**Example: Research Mode**
```typescript
{
  permissionMode: "plan",
  tools: ["Read", "Grep", "WebFetch", "WebSearch", "AskUserQuestion"]
}
```

### Persona-Based Modes

Combine permission restrictions with prompt-based persona definitions. The agent's system prompt defines operational perspective whilst permission modes enforce tool constraints.

**Example: Business Analyst Mode**
```typescript
{
  permissionMode: "plan",
  tools: ["Read", "Grep", "AskUserQuestion"],
  systemPrompt: `You are a Business Analyst...
    - Use non-technical language
    - Focus on business outcomes
    - Do not suggest technical implementations`
}
```

### Workflow-Enforcement Modes

Implement structured workflows by chaining modes with validation criteria. Each mode produces specific artefacts before transitioning.

**Example: Problem Definition Mode**
```typescript
{
  permissionMode: "plan",
  tools: ["AskUserQuestion"],
  systemPrompt: `Define the problem through questioning...
    Exit criteria: Complete problem statement with context, symptoms, impact, and goals`
}
```

[↑ Back to top](#table-of-contents)

---

## Mode Implementation Patterns

### Constraint-Based Pattern

Use permission modes to prevent specific operations during sensitive phases.

**Use Case:** Planning phase before implementation
**Permission Mode:** `plan`
**Tools:** Read-only tools plus research capabilities
**Exit Criteria:** Plan document meeting quality standards

### Persona-Based Pattern

Use system prompts to change operational perspective whilst permission modes enforce boundaries.

**Use Case:** Business analysis without technical suggestions
**Permission Mode:** `plan`
**Tools:** Limited to questioning and reading
**Exit Criteria:** Problem definition document

### Autonomous Execution Pattern

Use `acceptEdits` or `bypassPermissions` for supervised automation.

**Use Case:** Batch file modifications with oversight
**Permission Mode:** `acceptEdits`
**Tools:** All tools except dangerous operations
**Exit Criteria:** All modifications complete

[↑ Back to top](#table-of-contents)

---

## Integration with Claude Code CLI

According to the [Claude Agent SDK tutorial](https://www.datacamp.com/tutorial/how-to-use-claude-agent-sdk), Claude Code CLI and the SDK share the same foundation. The SDK enables creation of custom agents that operate within Claude Code's environment.

### Subagents

The [create custom subagents guide](https://code.claude.com/docs/en/sub-agents) explains subagents are specialised Claude instances with:
- Own context windows
- Specific personas
- Tool restrictions
- Permission modes

Subagents execute within Claude Code conversations, enabling mode-like behaviour through constrained agent instances.

### Skills and Custom Commands

Whilst not full modes, the [Claude Code features guide](https://www.producttalk.org/how-to-use-claude-code-features/) documents that skills and custom commands provide reusable workflows. Combined with subagents, these create mode-like experiences.

[↑ Back to top](#table-of-contents)

---

## Practical Implementation Guide

### File Structure

Custom modes are implemented as agent definition files in your workspace:

```
.claude/
├── modes/                          # Custom mode definitions
│   ├── problem-definer.agent.md   # Problem definition mode
│   ├── business-analyst.agent.md  # Business analysis mode
│   └── code-reviewer.agent.md     # Code review mode
├── rules/                          # Workspace rules
│   ├── documentation-first.md
│   └── [other rules]
└── settings.local.json             # Optional: mode-specific settings
```

**File Naming Convention:**
- Use `.agent.md` extension for agent/mode definitions
- Use kebab-case for filenames (e.g., `problem-definer.agent.md`)
- Place in `.claude/modes/` directory for organisation

### Step-by-Step: Creating a Basic Mode

#### Step 1: Create the Mode Directory

```bash
mkdir -p .claude/modes
```

#### Step 2: Create the Mode Definition File

Create `.claude/modes/research-assistant.agent.md`:

````markdown
---
name: research-assistant
description: Research and analysis mode with no file modification capabilities
version: 1.0.0
---

# Research Assistant Mode

## Purpose

Conduct research and analysis without making file modifications. Gather information from documentation, code, and web sources.

## Permission Configuration

**Permission Mode:** `plan`
- Prevents Write, Edit, and Bash operations
- Allows read-only analysis and research

**Allowed Tools:**
- Read
- Grep
- Glob
- WebFetch
- WebSearch
- AskUserQuestion

## Persona

You are a Research Assistant. Your role is to:
- Gather information from available sources
- Analyse code and documentation
- Answer questions with citations
- NEVER suggest implementations or make file changes

## Entry Behaviour

When invoked, acknowledge the research request and begin investigation using available read-only tools.

## Operational Rules

### Documentation-First Approach

**MUST:**
- Consult official documentation before answering
- Include citations for all claims
- State when information cannot be verified

**MUST NOT:**
- Speculate or guess at technical details
- Suggest implementations or code changes
- Make assumptions about user intent

### Research Output Format

Present findings as:
1. Summary of findings
2. Detailed analysis with citations
3. Gaps or limitations in available information
4. Recommendations for further research (if applicable)

## Exit Conditions

- Research objectives met and documented
- User confirms information is sufficient
- User explicitly exits mode
````

#### Step 3: Invoke the Mode

According to the [subagents documentation](https://code.claude.com/docs/en/sub-agents), invoke the mode using the Task tool:

```
Use the research-assistant mode to investigate authentication patterns in the codebase
```

Claude will spawn a subagent with the defined constraints and persona.

#### Step 4: Verify Mode Behaviour

Confirm the mode operates correctly:
- ✓ Can read files and search code
- ✓ Can fetch web documentation
- ✓ Cannot write or edit files
- ✓ Cannot execute bash commands
- ✓ Maintains defined persona

### Advanced: Mode with Embedded Rules

Create `.claude/modes/business-analyst.agent.md` with selective rule embedding:

````markdown
---
name: business-analyst
description: Business analysis mode for problem definition without technical implementation
version: 1.0.0
---

# Business Analyst Mode

## Purpose

Define business problems through questioning without suggesting technical implementations.

## Permission Configuration

**Permission Mode:** `plan`

**Allowed Tools:**
- AskUserQuestion
- Read (for context only)
- Grep (for understanding existing documentation)

## Persona and Constraints

You are a Business Analyst with no technical implementation knowledge. Focus exclusively on understanding business needs.

## Embedded Rules

### Documentation-First Response Requirements (from documentation-first.md)

**MUST:**
- Explicitly state when information cannot be verified
- Say "I don't know" when uncertain
- Ask for clarification rather than assuming

**MUST NOT:**
- Speculate or provide unverified answers
- Make assumptions about user intent
- Guess at technical details

### Rule Application Note

These rules are embedded directly in this mode definition to ensure consistent behaviour. According to workspace rule embedding practices, embedded rules take precedence over workspace-level rules for this mode's operation.

## Workflow

1. Request initial problem statement
2. Identify information gaps from business perspective
3. Generate targeted questions about:
   - Business context
   - Observable symptoms
   - Business impact
   - Desired business outcomes
4. Iterate until problem is sufficiently defined
5. Present problem summary (no solutions)
6. Exit upon user confirmation

## Exit Conditions

- User confirms problem definition is complete
- Maximum 10 questioning iterations reached
- User explicitly exits mode
````

### Directory Structure Best Practices

**Recommended Organisation:**

```
.claude/
├── modes/
│   ├── research/
│   │   ├── research-assistant.agent.md
│   │   └── documentation-analyser.agent.md
│   ├── planning/
│   │   ├── problem-definer.agent.md
│   │   └── architecture-planner.agent.md
│   └── implementation/
│       ├── safe-editor.agent.md
│       └── test-writer.agent.md
├── rules/
│   └── [workspace rules]
└── settings.local.json
```

**Alternative Flat Structure:**

```
.claude/
├── modes/
│   ├── 01-problem-definer.agent.md
│   ├── 02-requirements-analyst.agent.md
│   ├── 03-architecture-planner.agent.md
│   ├── 04-implementation.agent.md
│   └── 05-test-writer.agent.md
└── rules/
    └── [workspace rules]
```

Number prefixes indicate workflow sequence.

### Mode Invocation Patterns

**Direct Invocation:**
```
Use problem-definer mode to help me articulate the authentication issue
```

**Sequential Workflow:**
```
1. Use problem-definer mode to define the issue
2. After problem is defined, use architecture-planner mode to design approach
3. After plan is approved, use safe-editor mode to implement
```

**Conditional Invocation:**
```
If the task requires research only, use research-assistant mode
Otherwise, proceed with normal implementation
```

[↑ Back to top](#table-of-contents)

---

## Workflow Integration

Custom modes function as phases within implementation workflows:

```
Problem Definition Mode (plan + limited tools)
  ↓ produces: Problem statement document

Analysis Mode (plan + research tools)
  ↓ produces: Technical analysis document

Planning Mode (plan + full read access)
  ↓ produces: Implementation plan

Implementation Mode (acceptEdits + full tools)
  ↓ produces: Code changes

Verification Mode (plan + test tools)
  ↓ produces: Test results
```

Each mode enforces constraints appropriate to its phase. Artefacts from one mode inform subsequent modes.

[↑ Back to top](#table-of-contents)

---

## Implementation Guidelines

### Define Clear Constraints

Specify exactly which tools are needed and which must be restricted. Use allowlists for restrictive modes, denylists for permissive modes with specific exclusions.

### Document Exit Criteria

Each mode should have clear completion conditions. Artefact requirements, quality thresholds, or user confirmation define when mode exits.

### Embed Relevant Rules

According to workspace rule embedding practices, embed only rules applicable to the mode's operation. Problem definition modes embed documentation-first rules. Implementation modes embed code standards.

### Manage Context Budget

Selective rule embedding and focused tool access prevent context flooding whilst maintaining quality standards.

[↑ Back to top](#table-of-contents)

---

## Limitations and Considerations

### Platform-Level Features

Built-in modes (Default, Auto, Plan) are platform-level features with deep integration. Custom modes via SDK operate as subagents with permission-based constraints.

### Tool Restriction Scope

Permission modes control tool access but cannot modify tool behaviour. Tools either execute normally or are unavailable.

### State Management

Mode state persists through conversation context. Subagents maintain independent context windows but share conversation history with parent session.

### Transition Mechanisms

Transitions between modes require explicit invocation. Automatic mode switching based on context is not supported.

[↑ Back to top](#table-of-contents)

---

## Official Documentation Sources

Implementation of custom modes should reference:

- [Claude Agent SDK Overview](https://platform.claude.com/docs/en/agent-sdk/overview) - Core SDK concepts and capabilities
- [Permission Configuration](https://platform.claude.com/docs/en/agent-sdk/permissions) - Permission modes and tool restrictions
- [Create Custom Subagents](https://code.claude.com/docs/en/sub-agents) - Subagent creation within Claude Code
- [Claude Agent SDK Python Reference](https://platform.claude.com/docs/en/agent-sdk/python) - Python API documentation
- [ClaudeLog Plan Mode](https://claudelog.com/mechanics/plan-mode/) - Plan mode detailed behaviour
- [Common Workflows](https://code.claude.com/docs/en/common-workflows) - Claude Code workflow patterns

[↑ Back to top](#table-of-contents)

---

## Complete Example: Problem Definition Mode

### File: `.claude/modes/problem-definer.agent.md`

````markdown
---
name: problem-definer
description: Guide users through systematic problem identification using structured questioning
version: 1.0.0
---

# Problem Definition Mode

## Purpose

Help users articulate and define problems clearly through structured questioning before attempting solutions.

## Permission Configuration

**Permission Mode:** `plan`
- Prevents Write, Edit, and Bash operations
- No implementation suggestions possible

**Allowed Tools:**
- AskUserQuestion (primary tool for gathering information)
- Read (for understanding existing documentation)
- Grep (for searching context)

## Persona and Constraints

**You are a Business Analyst with the following constraints:**

- **Assume no technical knowledge:** Use business-focused language
- **Problem definition only:** MUST NOT suggest solutions or implementations
- **Documentation-first:** All information from verified sources or user input
- **Focus on "what" not "how":** Understand the problem, not the solution

## Embedded Rules

### Documentation-First Response Requirements

**MUST:**
- Explicitly state when information cannot be verified through documentation
- Say "I don't know" or "I cannot verify this information" when uncertain
- Ask for clarification rather than assuming user intent or requirements

**MUST NOT:**
- Speculate or provide unverified answers
- Make assumptions about what the user means
- Guess at technical details or implementations
- Suggest solutions or implementation approaches

## Workflow

### Phase 1: Initial Problem Statement

Request initial problem description from the user. This serves as the foundation for questioning.

### Phase 2: Iterative Refinement

Generate targeted questions to clarify and expand the problem definition:

**Context Questions:**
- What business area or department does this occur in?
- Who are the key stakeholders affected?
- What organisational or resource constraints exist?

**Symptom Questions:**
- What observable outcomes or behaviours are concerning?
- What are users or staff experiencing?
- When did this first become noticeable?

**Impact Questions:**
- How many people or business units are affected?
- What are the business consequences?
- How often does this occur?

**Goal Questions:**
- What business outcome would you like to achieve?
- How will you know when the problem no longer exists?
- What does success look like from your perspective?

### Phase 3: Problem Summary

Present structured summary for user confirmation:
- Problem statement (1-2 sentences)
- Context and environment
- Symptoms and observable issues
- Impact and affected parties
- Desired outcome
- Known constraints

## State Tracking

Track the following throughout questioning:
- Initial statement
- Context (business environment, stakeholders, constraints)
- Symptoms (observable outcomes)
- Impact (affected parties, severity, consequences)
- Goals (desired outcomes, success criteria)
- Questions asked (avoid repetition)
- Iteration count (enforce maximum limit)

## Exit Conditions

**Successful Completion:**
- Core elements present (statement, symptoms, goals)
- Context provides adequate understanding
- Impact is quantified from business perspective
- User confirms summary accuracy

**Alternative Exits:**
- Maximum 10 questioning iterations reached
- User explicitly requests exit

## Output Artefact

Upon completion, output problem definition document with:
- Problem Statement
- Business Context
- Symptoms and Observable Issues
- Impact Assessment
- Desired Outcomes
- Constraints and Limitations
- Date and Participants

This mode operates as a constrained subagent within Claude Code, enforcing non-implementation behaviour through tool restrictions whilst the persona guides questioning strategy.
````

### Usage Example

**User Invocation:**
```
Use problem-definer mode to help me articulate the authentication issue we're experiencing
```

**Mode Behaviour:**
1. Acknowledges request in Business Analyst persona
2. Requests initial problem statement
3. Analyses statement for gaps
4. Generates 1-3 targeted questions
5. Iterates until problem is sufficiently defined
6. Presents summary for confirmation
7. Outputs problem definition document
8. Exits mode

**Expected Output:**
A structured problem definition document with no technical implementation suggestions, focusing solely on business understanding of the problem.

[↑ Back to top](#table-of-contents)

---

## Notes

This documentation derives from official Claude Agent SDK and Claude Code documentation. Implementation details may vary based on SDK version and Claude Code environment configuration.

[↑ Back to top](#table-of-contents)
