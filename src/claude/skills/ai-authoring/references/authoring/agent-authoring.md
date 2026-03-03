# Agent Authoring

Guide content creation for agent artifacts: autonomous AI agents spawned as subprocesses to perform specialised tasks.

---

## File Structure

```
src/{platform}/agents/{name}.agent.md
```

<!-- TODO: Define naming conventions for agents (e.g. lowercase, hyphens, noun-based names) -->

---

## Frontmatter Fields

```yaml
---
name: {name}
description: {description}
tools:
  - {tool}
mcpServers:
  - {server}
release:
  publish: true|false
  platforms: [{platforms}]
  validation:
    - {rule}
---
```

<!-- TODO: Define the complete list of available tools and their identifiers -->
<!-- TODO: Define which frontmatter fields are required vs optional -->
<!-- TODO: Define how MCP server configuration should be specified -->

---

## Content Requirements

<!-- TODO: Define required sections in an agent file (e.g. purpose, workflow, constraints) -->
<!-- TODO: Define how the agent's scope and boundaries should be described -->
<!-- TODO: Define how the agent should communicate its output -->

---

## Tool Selection Guidance

<!-- TODO: Define how to select the minimum tool set for an agent's task -->
<!-- TODO: Define when each tool (read, write, edit, grep, glob, bash, web) is appropriate -->

---

## Rule Embedding

<!-- TODO: Define when and how to embed rules in agent files -->
<!-- TODO: Define which rules are commonly required for agents -->
<!-- TODO: Reference rule-embedding and rule-copying standards -->

---

## AI-Targeted Language Enforcement

<!-- TODO: Define agent-specific language patterns to enforce or forbid -->
<!-- TODO: Define how to write agent output format requirements -->

---

## Commit Checklist

<!-- TODO: Define files to stage and commit message format for an agent -->
