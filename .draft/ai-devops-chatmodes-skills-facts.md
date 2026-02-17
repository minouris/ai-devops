# AI DevOps: Chatmodes vs Skills Research Findings

**Domain:** Custom agent capability systems
**Research Focus:** Comparing Custom Chatmodes and Skills implementation, structure, and usage in Claude Code and GitHub Copilot Chat

---

## FINDING-2026-02-17-1
**Captured:** 2026-02-17
**Source:** GitHub Copilot Official Documentation (docs.github.com), agentskills.io specification

**Agent Skills: Open Standard Format**

Agent Skills are an **open standard** (agentskills.io specification) originally developed by Anthropic and adopted by multiple AI agent products including:
- GitHub Copilot (VS Code, CLI, coding agent)
- Claude Code
- Augment Code
- Other skills-compatible agents

**Key characteristics:**
- **Portable** across different AI systems
- **Open standard** that accepts ecosystem contributions
- Used by both Anthropic and GitHub/Microsoft products

**File structure:**
```
.github/skills/skill-name/
  └── SKILL.md          # Required
  └── scripts/          # Optional
  └── references/       # Optional
  └── assets/           # Optional

.claude/skills/skill-name/
  └── SKILL.md          # Alternative location
```

**SKILL.md format:**
- YAML frontmatter with required fields:
  - `name` (required): 1-64 chars, lowercase alphanumeric + hyphens only
  - `description` (required): 1-1024 chars, describes what skill does and when to use
  - `license` (optional)
  - `metadata` (optional)
  - `compatibility` (optional)
- Markdown body: instructions, examples, guidelines
- Can reference scripts, examples, or resources in skill directory

**Discovery mechanism:**
- Agent reads metadata (name + description) at startup (~100 tokens)
- Loads full SKILL.md body when skill is activated (recommended <5000 tokens)
- Loads additional resources (scripts, references) only when needed
- Progressive disclosure pattern for context efficiency

**Sources:**
- GitHub Docs: "About agent skills" (docs.github.com/en/copilot/concepts/agents/about-agent-skills)
- agentskills.io specification
- VS Code Documentation: "Use Agent Skills in VS Code"

---

## FINDING-2026-02-17-2
**Captured:** 2026-02-17
**Source:** GitHub Copilot VS Code Documentation (code.visualstudio.com), GitHub Docs

**GitHub Copilot: Custom Agents (formerly "Custom Chatmodes")**

GitHub Copilot in VS Code supports **custom agents** defined using `.agent.md` files.

**File structure:**
```
.github/agents/agent-name.agent.md
```

**Historical note:**
- Previously used `.chatmode.md` extension in `.github/chatmodes/` folder
- VS Code still recognizes old chatmode files as custom agents (backward compatibility)
- Current recommended format is `.agent.md` in `.github/agents/`

**.agent.md format:**
- YAML frontmatter with fields:
  - `name`: The name of the custom agent
  - `description`: What the agent does and when to use
  - `tools`: Optional list of available tools (read, edit, search, web, MCP servers)
  - `mcp-servers`: Optional list of MCP server configs (for github-copilot target)
  - `handoffs`: Optional property for transitioning between custom agents
- Markdown body: persona, instructions, project knowledge, standards, examples

**Key characteristics:**
- **VS Code-specific** (not portable to other agents)
- Defines a **persona or workflow orchestrator**
- Can combine multiple skills and instructions
- Can reference specific tool permissions
- Supports handoffs between agents

**Current file example** (from workspace):
```yaml
---
name: analysis
description: Systematically capture raw research findings, handle user filtering and disproof during research, create curated analysis outputs with user approval
tools: [read, edit, search, web, ms-vscode.vscode-websearchforcopilot/websearch]
---
```

**Sources:**
- VS Code Docs: "Custom agents in VS Code" (code.visualstudio.com/docs/copilot/customization/custom-agents)
- GitHub Docs: "Creating custom agents for Copilot coding agent"

---

## FINDING-2026-02-17-3
**Captured:** 2026-02-17
**Source:** GitHub community discussion (github.com/orgs/community/discussions/183962)

**Conceptual Differences: Skills vs Custom Agents vs Custom Instructions**

GitHub Copilot ecosystem uses three distinct customization mechanisms:

**1. Repository Custom Instructions (.github/copilot-instructions.md)**
- **Purpose:** Always-on, repo-specific guidance
- **Use case:** Stable, repo-wide norms (coding style, architecture, build commands)
- **Behavior:** Automatically applied whenever Copilot interacts with repo (passive but persistent)
- **Scope:** Project-wide conventions
- Rule of thumb: "Use for anything that should always apply, regardless of which agent or skill is being used"

**2. Agent Skills (.github/skills or .claude/skills)**
- **Purpose:** Encapsulate specific, reusable capabilities agents can call on-demand
- **Use case:** Task-oriented, modular logic shared across agents and repositories
- **Behavior:** Invoked automatically when relevant OR explicitly by user (e.g., `/my-skill`)
- **Scope:** Specific domains/workflows
- **Portable:** Cross-platform (agentskills.io standard)
- Rule of thumb: "Use for task-specific logic that can be reused in multiple contexts"
- Examples: "github-actions-failure-debugging", "webapp-testing"

**3. Custom Agents (.github/agents/*.agent.md)**
- **Purpose:** Define a persona or workflow orchestrator combining skills and instructions
- **Use case:** Named, persistent "agent" handling complex workflows end-to-end
- **Behavior:** Select skills, follow repo instructions, manage task orchestration
- **Scope:** Complex multi-step workflows
- **Platform-specific:** VS Code/GitHub Copilot only (not portable)
- Rule of thumb: "Use when you want a consistent helper that can handle multi-step workflows or complex tasks"
- Example: "CI-Debugger agent" that reads logs, applies debugging skill, suggests fixes

**Recommended pattern:**
1. Define repo-wide instructions for consistent context
2. Create modular skills for repeatable, task-specific logic
3. Use custom agents only when you need named, orchestrated persona handling complex workflows or multiple skills together

**Sources:**
- GitHub Community Discussion: "Clarifying the difference between Repository Custom Instructions, Agent Skills, and Custom Agents"

---

## FINDING-2026-02-17-4
**Captured:** 2026-02-17
**Source:** VS Code Documentation, agentskills.io, Augment documentation

**Skills vs Custom Instructions: Comparison Table**

| Feature | Agent Skills | Custom Instructions |
|---------|-------------|-------------------|
| **Purpose** | Specialized capabilities and workflows | Coding standards and guidelines |
| **Portability** | Cross-platform (agentskills.io standard) | Platform-specific (VS Code, GitHub.com) |
| **Content** | Instructions, scripts, examples, resources | Instructions only |
| **Scope** | Task-specific, loaded on-demand | Always applied (or via glob patterns) |
| **Standard** | Open standard (agentskills.io) | VS Code-specific or Copilot-specific |
| **Discovery** | Metadata-based (name + description) | Content-based or always-applied |
| **Use case** | Framework-specific knowledge, tool guides, domain expertise | Code style, project architecture, team conventions |

**When to use Skills:**
- Framework-specific knowledge (React patterns, Django best practices)
- Tool usage guides (Docker workflows, CI/CD procedures)
- Domain expertise (security practices, performance optimization)
- Reusable capabilities across projects
- Include scripts, examples, or resources alongside instructions

**When to use Custom Instructions:**
- Code style preferences
- Project architecture guidelines
- Team conventions
- Project-specific coding standards
- Simple instructions relevant to almost every task

**Sources:**
- Augment CLI Documentation: "Skills" (docs.augmentcode.com/cli/skills)
- VS Code Documentation: "Agent Skills vs custom instructions"

---

## FINDING-2026-02-17-5
**Captured:** 2026-02-17
**Source:** Anthropic Claude Code documentation, Reddit discussions, Medium articles

**Claude Code: CLAUDE.md vs Skills vs Slash Commands**

Claude Code (Anthropic's agentic coding tool) supports multiple customization mechanisms:

**1. CLAUDE.md (or AGENTS.md)**
- **Location:** Project root directory
- **Purpose:** Always-on project context and instructions
- **Behavior:** Automatically injected into agent's context for every session
- **Best practice:** Keep minimal - only universally applicable instructions
- **Pattern:** Use as entry point that references other markdown files with task-specific instructions
- **Context impact:** Loaded every time, so should be concise

**Recommended CLAUDE.md structure:**
- Basic project context (what and why)
- How to do basic development tasks
- List of task-specific instruction files with descriptions
- Let Claude decide which files to read based on relevance

**2. Skills (.claude/skills/)**
- **Location:** `.claude/skills/skill-name/SKILL.md` (project or user home directory)
- **Format:** Follows agentskills.io specification (same as GitHub Copilot)
- **Purpose:** Better-structured, dynamically loaded capabilities
- **Behavior:** Invoked by Claude automatically when relevant OR manually by user with `/skill-name`
- **Discovery:** Claude sees available skills through metadata at startup
- **Portability:** Works across Claude Code, GitHub Copilot, and other skills-compatible agents

**3. Slash Commands (custom commands)**
- **Purpose:** Package repeatable workflows users can share
- **Examples:** `/review-pr`, `/deploy-staging`
- **Behavior:** Invoked manually by user OR by Claude itself
- **Similarity to skills:** Very similar in function
- **Design intent:** Primarily designed for user invocation (vs skills designed for Claude to use)
- **Note:** May be merged with skills in future (request pending with Anthropic)

**4. Plugins**
- **Purpose:** Package skills, slash commands, agents, hooks, and MCP servers together
- **Example:** Anthropic's official `frontend-design` plugin (essentially just a skill)
- **Distribution:** Plugin marketplace

**Key insight:**
- **CLAUDE.md = always-on, minimal universal context**
- **Skills = on-demand, specialized capabilities** (agentskills.io standard)
- **Slash commands = user-invoked workflows** (may merge with skills)
- **Plugins = bundled distribution format**

**Source distinction from chatmodes:**
Claude Code does NOT use the term "chatmodes" or have custom chatmodes feature. It uses:
- CLAUDE.md (always-on instructions)
- Skills (on-demand capabilities following agentskills.io)
- Custom slash commands (packaged workflows)

**Sources:**
- Reddit: "Understanding CLAUDE.md vs Skills vs Slash Commands vs Plugins"
- HumanLayer Blog: "Writing a good CLAUDE.md"
- Medium/Dometrain: "Creating the Perfect CLAUDE.md for Claude Code"

---

## FINDING-2026-02-17-6
**Captured:** 2026-02-17
**Source:** VS Code documentation, GitHub Copilot documentation

**Terminology Evolution: Chatmodes → Agents**

**Historical naming:**
- GitHub Copilot in VS Code previously called customization files "chatmodes"
- Used `.chatmode.md` extension
- Stored in `.github/chatmodes/` folder

**Current naming:**
- Now called "custom agents"
- Use `.agent.md` extension
- Store in `.github/agents/` folder

**Backward compatibility:**
- VS Code still recognizes `.chatmode.md` files in `.github/chatmodes/` as custom agents
- No breaking change for existing implementations

**Important distinction:**
- "Custom chatmodes" is **legacy GitHub Copilot terminology** (VS Code-specific feature)
- "Chatmodes" were **never a Claude Code feature**
- Claude Code uses: CLAUDE.md + Skills (agentskills.io) + Slash Commands + Plugins

**Current state (Feb 2026):**
- GitHub Copilot: Uses "custom agents" (.agent.md files)
- Claude Code: Uses Skills (agentskills.io) + CLAUDE.md + Slash Commands
- **Both now support agentskills.io standard for skills**

**Sources:**
- VS Code Documentation: "Custom agents in VS Code" (mentions legacy .chatmode.md support)

---

## FINDING-2026-02-17-7
**Captured:** 2026-02-17
**Source:** agentskills.io specification, GitHub Copilot documentation

**Progressive Disclosure Pattern in Skills**

Skills use **progressive disclosure** for context efficiency:

**Three levels of loading:**

1. **Startup (all skills):** ~100 tokens per skill
   - Loads: `name` and `description` fields from YAML frontmatter
   - Purpose: Agent sees what skills are available
   - Impact: Minimal context usage

2. **Activation (selected skill):** <5000 tokens recommended
   - Loads: Full SKILL.md body (markdown content after frontmatter)
   - Purpose: Agent gets instructions, examples, guidelines
   - When: Agent determines skill is relevant to task OR user explicitly invokes
   - Best practice: Keep main SKILL.md under 500 lines

3. **On-demand (as needed):** Variable
   - Loads: Referenced files (scripts/, references/, assets/)
   - Purpose: Access detailed documentation, run scripts, use templates
   - When: Skill instructions direct agent to specific resource
   - Best practice: Keep references one level deep, avoid nested chains

**Benefits:**
- Efficient context window usage
- Many skills available without flooding context
- Only relevant content loaded when needed
- Scalable to many skills per project

**File structure best practices:**
```
skill-name/
├── SKILL.md           # Main instructions (<500 lines, <5000 tokens)
├── scripts/           # Executable scripts (loaded on-demand)
├── references/        # Detailed docs (loaded on-demand)
│   ├── REFERENCE.md   # Technical reference
│   └── FORMS.md       # Templates, structured data
└── assets/            # Static resources (loaded on-demand)
    ├── templates/
    ├── images/
    └── data/
```

**Sources:**
- agentskills.io specification: "Progressive disclosure"
- Augment documentation: "Skill File Structure"

---

## FINDING-2026-02-17-8
**Captured:** 2026-02-17
**Source:** GitHub Copilot documentation, VS Code documentation

**Custom Agents in GitHub Copilot: Advanced Features**

GitHub Copilot custom agents (.agent.md files) support advanced orchestration features:

**1. Tool specification:**
- Define exact tools available to agent via `tools` field in frontmatter
- Built-in tools: `read`, `edit`, `search`, `web`
- MCP server tools: Can reference MCP servers via `mcp-servers` field
- Example: `tools: [read, edit, search, web, ms-vscode.vscode-websearchforcopilot/websearch]`

**2. MCP Server integration:**
- `mcp-servers` field: List of Model Context Protocol server configurations
- Target-specific: `target: github-copilot`
- Extends agent capabilities with external tools/data sources

**3. Handoffs between agents:**
- `handoffs` property: Configure transitioning between custom agents
- Enables complex workflows where one agent hands off to another
- Use case: Specialized agents for different phases of task

**4. Model selection:**
- UI dialog available in VS Code to select AI model for agent
- Can customize which model powers each custom agent

**5. Scope options:**
- **Workspace-level:** `.github/agents/*.agent.md` in repository
- **User profile-level:** Create in current VS Code profile folder (shared across workspaces)

**Distinction from skills:**
- Custom agents = orchestration, persona, workflow management
- Skills = modular, reusable capabilities agents can invoke
- Custom agents can use multiple skills
- Skills are tool-agnostic; custom agents specify exact tools

**Sources:**
- GitHub Docs: "Creating custom agents for Copilot coding agent"
- VS Code Docs: "Custom agents in VS Code"

---

## FINDING-2026-02-17-9
**Captured:** 2026-02-17
**Source:** Anthropic documentation (platform.claude.com), GitHub (anthropics/skills repository)

**Claude API and Claude Code: Skills Implementation Differences**

**Claude API (claude.ai and API):**
- Supports **pre-built Agent Skills** (available to all users)
- Supports **custom Skills** (uploaded via API)
- Skills uploaded via API are **not available on claude.ai**
- Skills can be used via API calls
- Pre-built skills available in virtual machine with filesystem access

**Claude Code:**
- Supports **custom Skills only** (not pre-built skills from API)
- Skills are **filesystem-based** (no API upload required)
- Location: `.claude/skills/` in project or user home directory
- Follows agentskills.io specification
- Skills loaded directly from filesystem by reading SKILL.md

**Skill loading mechanism in Claude Code:**
1. Claude uses bash to read `SKILL.md` from filesystem
2. Brings instructions into context window
3. Can execute scripts or access resources in skill directory
4. Progressive loading (metadata → instructions → resources)

**Anthropic's official skills repository:**
- GitHub: `anthropics/skills`
- Contains example skills demonstrating capabilities
- Each skill in own folder with SKILL.md
- Can be used as reference for building custom skills
- Examples: PDF processing, document skills, frontend design

**Sources:**
- Claude API Docs: "Agent Skills" (platform.claude.com)
- GitHub: anthropics/skills repository

---

## FINDING-2026-02-17-10
**Captured:** 2026-02-17
**Source:** Web search results synthesis

**Summary: Key Terminology Clarification**

**IMPORTANT CORRECTION TO RESEARCH QUESTION:**

The user asked about "Custom Chatmodes" in Claude Code, but this appears to be a **terminology misunderstanding**:

**Claude Code (Anthropic) DOES NOT have "custom chatmodes":**
- No feature called "chatmodes"
- No `.chatmode.md` files
- Anthropic products use: CLAUDE.md + Skills (agentskills.io) + Slash Commands

**"Custom Chatmodes" was a GitHub Copilot (VS Code) feature:**
- Legacy VS Code feature for GitHub Copilot
- Used `.chatmode.md` extension in `.github/chatmodes/`
- **Now renamed to "custom agents"** using `.agent.md` in `.github/agents/`
- VS Code still supports legacy chatmode files for backward compatibility

**Current accurate terminology (Feb 2026):**

**GitHub Copilot (VS Code):**
1. Custom agents (.agent.md) - orchestration, persona, workflow management
2. Skills (SKILL.md, agentskills.io) - modular, reusable capabilities
3. Custom instructions (copilot-instructions.md) - always-on repo guidance

**Claude Code (Anthropic):**
1. CLAUDE.md - always-on project context
2. Skills (SKILL.md, agentskills.io) - modular, reusable capabilities
3. Slash commands - packaged workflows
4. Plugins - bundled distribution

**Both systems:**
- Now support the **same agentskills.io standard for skills**
- Skills are **portable** between GitHub Copilot and Claude Code
- Skills use same file format (SKILL.md with YAML frontmatter)

**Research conclusion:**
The question should actually compare:
- **GitHub Copilot custom agents** (.agent.md) vs **Skills** (agentskills.io)
- **Claude Code CLAUDE.md + Slash Commands** vs **Skills** (agentskills.io)

NOT "Custom Chatmodes vs Skills" because chatmodes is legacy VS Code terminology, not a Claude Code feature.

**Sources:**
- All previous findings synthesized

---

## FINDING-2026-02-17-11
**Captured:** 2026-02-17
**Source:** GitHub Copilot Official Documentation (docs.github.com), community blog posts

**Custom Prompts: GitHub Copilot Prompt Files**

GitHub Copilot supports **prompt files** (.prompt.md) as a separate customization mechanism distinct from both skills and custom agents.

**File structure:**
```
.github/prompts/
  ├── explain-code.prompt.md
  ├── unit-tester.prompt.md
  ├── agent.data-engineer.prompt.md
  └── task-manager.prompt.md
```

**Prompt file format:**
- Markdown file with `.prompt.md` extension
- No YAML frontmatter required (unlike skills and agents)
- Can contain direct instructions mimicking Copilot Chat format
- Can reference other workspace files using:
  - Markdown links: `[index](../../web/index.ts)`
  - Chat syntax: `#file:../../web/index.ts`
  - Paths relative to prompt file location

**Key characteristics:**
- **User-invoked:** Must be explicitly added to chat context by user
- **Task-specific:** Single-purpose prompts for specific workflows
- **Composable:** Can reference external files for additional context
- **Platform-specific:** Only available in VS Code, Visual Studio, JetBrains IDEs
- **Not automatically loaded:** Unlike custom instructions, not automatically added to context

**Use cases:**
- Test-Driven Development workflows (AAA pattern enforcement)
- Code explanation with specific format requirements
- Agent mode prompts (`agent.<use-case>.prompt.md`)
- Prompts with external URL references (`fetch.<use-case>.prompt.md`)

**Composition capabilities:**
- Can reference "prompt snippets" - reusable markdown files in custom folders
- Example pattern:
  ```markdown
  [Coding Standards](./prompt-snippets/coding-standards.md)
  [Response Personality](./prompt-snippets/copilot-personality.md)
  ```
- Can reference API specs, documentation, diagrams, screenshots
- GitHub Copilot retrieves referenced file contents when prompt is used

**Difference from custom instructions:**
- **Custom instructions** (.github/copilot-instructions.md): Always applied to every request
- **Prompt files** (.github/prompts/*.prompt.md): Applied only when explicitly added to context

**Difference from skills:**
- **Skills:** Automatically loaded when relevant based on description metadata
- **Prompt files:** Must be manually added to chat (drag-and-drop or + button)

**Difference from custom agents:**
- **Custom agents:** Define orchestration, persona, tool selection
- **Prompt files:** Define single-task instructions without orchestration

**IDE integration:**
- Can be configured in IDE settings for specific features:
  - `github.copilot.chat.commitMessageGeneration.instructions`
  - `github.copilot.chat.pullRequestDescriptionGeneration.instructions`

**Status:** Public preview (subject to change)

**Sources:**
- GitHub Docs: "Using prompt files", "Your first prompt file"
- Community blog: raffertyuy.com "GitHub Copilot | Custom Prompt Files & Folder Structure for Teams"
- Microsoft .NET Blog: "Prompt Files and Instructions Files Explained"

---

## FINDING-2026-02-17-12
**Captured:** 2026-02-17
**Source:** agentskills.io specification, GitHub Copilot documentation, Claude Code documentation

**Internal Organization Analysis: Discrete Prompts/Instructions Within Each Type**

Analysis of whether each customization type supports internal organization with discrete sub-prompts or instructions with distinct rules and responsibilities.

### Skills (agentskills.io standard)

**Internal organization:** ✅ **Extensive support**

**Structure:**
```
skill-name/
├── SKILL.md              # Main instructions (<500 lines)
├── scripts/              # Executable code (Python, Bash, JS)
├── references/           # Additional documentation
│   ├── REFERENCE.md      # Technical reference
│   ├── FORMS.md          # Templates, structured data
│   └── domain-specific.md
└── assets/               # Static resources
    ├── templates/
    ├── images/
    └── data/
```

**Discrete organization capabilities:**
- **Main instructions:** SKILL.md body contains high-level workflow orchestration
- **References:** Separate markdown files for discrete phase instructions
  - Loaded on-demand when skill references them
  - Example: Analysis phase rules in `references/analyze-phase.md`
  - Collation phase rules in `references/collate-phase.md`
  - Reporting phase rules in `references/report-phase.md`
  - Only loaded when workflow reaches that phase
- **Scripts (optional):** Executable code for automation tasks
  - Python data analysis scripts
  - Bash automation scripts
  - JavaScript utilities
  - Loaded and executed only when workflow requires
- **Assets:** Templates, schemas, sample data
  - Output templates
  - Configuration templates
  - Lookup tables

**Progressive disclosure pattern:**
- Level 1 (metadata): ~100 tokens at startup
- Level 2 (main instructions): <5000 tokens when activated
- Level 3 (references/scripts/assets): Loaded only when referenced in instructions

**Example discrete organization:**
A data analysis skill could have:
- SKILL.md: High-level workflow "analyze, collate, report"
- references/analyze-phase.md: Discrete analysis instructions and rules
- references/collate-phase.md: Discrete collation instructions and rules
- references/report-phase.md: Discrete reporting instructions and rules
- references/statistical_methods.md: Reference for analysis standards
- templates/report-template.md: Output template
- scripts/ (optional): Helper scripts if automation needed

**Best practice:** "Keep file references one level deep from SKILL.md. Avoid deeply nested reference chains."

---

### Custom Agents (GitHub Copilot .agent.md)

**Internal organization:** ⚠️ **Limited support**

**Structure:**
```
.github/agents/
  └── agent-name.agent.md
```

**.agent.md is single file:**
- YAML frontmatter: metadata, tools, handoffs
- Markdown body: persona, instructions, standards

**Discrete organization capabilities:**
- **Within file:** Can use markdown headings to organize sections
  - Persona section
  - Project knowledge section
  - Tools section
  - Standards section
- **External references:** Can reference prompt files
  - Via `tools` field can specify which prompt files apply
  - Can reference MCP servers for external capabilities
- **No built-in subdirectory structure** like skills

**Composition pattern:**
Custom agents can **use** skills and prompt files:
- Tools field: `tools: [read, edit, search, web]`
- Can invoke skills by name
- Can hand off to other agents via `handoffs` property

**Example discrete organization:**
An agent could orchestrate:
1. Invoke skill A for analysis (discrete step)
2. Invoke skill B for collation (discrete step)
3. Invoke skill C for reporting (discrete step)
4. Hand off to specialist agent for review

But the agent itself is a single .agent.md file organizing these calls.

---

### Custom Prompts (GitHub Copilot .prompt.md)

**Internal organization:** ✅ **Reference-based support**

**Structure:**
```
.github/prompts/
  └── task-name.prompt.md

.github/prompt-snippets/    # Custom folder (not required)
  ├── coding-standards.md
  ├── personality.md
  └── domain-rules.md
```

**Discrete organization capabilities:**
- **Main prompt:** Single .prompt.md file with task instructions
- **Referenced snippets:** Can reference other markdown files
  - `[Coding Standards](./prompt-snippets/coding-standards.md)`
  - `[Domain Rules](./prompt-snippets/domain-rules.md)`
- **Referenced code:** Can reference actual code files as examples
  - `[index](../../web/index.ts)`
  - `#file:../../web/index.ts`
- **External URLs:** Can reference internet/intranet documentation (VSCode 1.99+)

**Composition pattern:**
```markdown
# Unit Test Generator

[Follow AAA pattern](./prompt-snippets/aaa-pattern.md)
[Use naming conventions](./prompt-snippets/test-naming.md)

## Steps
1. Arrange: [details]
2. Act: [details]
3. Assert: [details]

Reference API: [API Spec](../../docs/api-spec.md)
```

**Example discrete organization:**
A complex prompt could have:
- Main prompt: High-level task "create unit tests"
- Snippet 1: AAA pattern rules (discrete responsibility)
- Snippet 2: Naming convention rules (discrete responsibility)
- Snippet 3: Coverage requirements (discrete responsibility)
- Referenced files: API specs, example tests

**Limitation:** All referenced files loaded when prompt is added to context (not progressive like skills)

---

### CLAUDE.md / AGENTS.md (Always-on instructions)

**Internal organization:** ✅ **Reference-based support**

**Structure:**
```
project-root/
  ├── CLAUDE.md           # Main entry point
  └── docs/
      ├── architecture.md
      ├── testing.md
      └── deployment.md
```

**Discrete organization capabilities:**
- **Main file:** Single CLAUDE.md with minimal universal instructions
- **Referenced files:** Can reference task-specific markdown files
  - List files with descriptions
  - Let agent decide which to read based on task
- **External references:** Can reference diagrams, schemas, documentation

**Best practice pattern:**
From community: "Instead of including all different instructions in CLAUDE.md, keep task-specific instructions in separate markdown files with self-descriptive names somewhere in your project. Then, in your CLAUDE.md file, include a list of these files with a brief description of each, and instruct Claude to decide which (if any) are relevant and to read them before starting work."

**Example discrete organization:**
```markdown
# CLAUDE.md

## Project Context
[Brief description]

## Available Documentation
- [Architecture](./docs/architecture.md) - System design and components
- [Testing](./docs/testing.md) - Test procedures and standards
- [Deployment](./docs/deployment.md) - Deploy workflow

**Instructions:** Before starting work, read relevant documentation files based on the task.
```

Agent chooses which discrete files to read based on task.

**Limitation:** 
- All content loaded into context (no progressive disclosure like skills)
- Agent must manually decide what to load

---

### Custom Instructions (.github/copilot-instructions.md)

**Internal organization:** ✅ **Reference-based support**

**Structure:**
```
.github/
  ├── copilot-instructions.md    # Main file
  └── prompt-snippets/            # Custom folder
      ├── coding-standards.md
      ├── architecture.md
      └── conventions.md
```

**Discrete organization capabilities:**
- **Main file:** Single always-on instruction file
- **Referenced snippets:** Can reference other markdown files
  - `[Coding Standards](./prompt-snippets/coding-standards.md)`
  - `[Architecture Guidelines](./prompt-snippets/architecture.md)`
- **Images/diagrams:** Can reference visual assets
  - Architecture diagrams
  - Design mockups
  - Database schemas

**Example discrete organization:**
```markdown
# copilot-instructions.md

[Coding Standards](./prompt-snippets/coding-standards.md)
[Architecture Rules](./prompt-snippets/architecture.md)

## Project-specific instructions
- Use TypeScript for all new code
- Follow repository structure defined in architecture

[Reference database schema](./docs/db-schema.png)
```

**Limitation:** 
- All referenced content loaded into every request
- No progressive disclosure
- Can cause context bloat if too many references

**Important:** "As multiple custom prompts are being stitched together, it is very important to ensure that your prompts do not conflict with each other."

---

### Slash Commands (Claude Code)

**Internal organization:** ⚠️ **Limited information available**

**Structure:**
- Custom slash commands defined in Claude Code configuration
- Can package repeatable workflows
- Examples: `/review-pr`, `/deploy-staging`

**Discrete organization capabilities:**
- Each slash command is a discrete workflow
- Similar to skills but user-invoked
- May reference skills internally
- Limited documentation on internal structure

**Note:** Slash commands and skills may be merged in future per community request

---

**Sources:**
- agentskills.io specification: "Progressive disclosure", "Directory structure"
- GitHub Copilot documentation: Custom agents, prompt files, custom instructions
- Community blog posts: CLAUDE.md best practices, prompt file organization
- Claude Code documentation snippets from web search

---

## FINDING-2026-02-17-13
**Captured:** 2026-02-17
**Source:** Research synthesis from all previous findings

**Comprehensive Comparison: Custom Prompts vs Skills vs Agents/Modes**

| Feature | Custom Prompts (.prompt.md) | Skills (SKILL.md) | Custom Agents (.agent.md) | CLAUDE.md / AGENTS.md |
|---------|----------------------------|-------------------|--------------------------|----------------------|
| **Platform** | GitHub Copilot only | Cross-platform (agentskills.io) | GitHub Copilot only | Claude Code / VS Code |
| **File extension** | .prompt.md | SKILL.md | .agent.md | CLAUDE.md, AGENTS.md |
| **Location** | .github/prompts/ | .github/skills/ or .claude/skills/ | .github/agents/ | Project root |
| **Activation** | User must explicitly add | Auto-loaded when relevant | User selects agent | Always loaded |
| **Portability** | Not portable | Portable (agentskills.io) | Not portable | Not portable |
| **Frontmatter** | None required | YAML required (name, description) | YAML required | None |
| **Purpose** | Single-task instructions | Modular reusable capabilities | Orchestration & persona | Always-on context |
| **Scope** | Task-specific | Domain/workflow-specific | Multi-step orchestration | Project-wide |
| **Discovery** | Manual (user adds) | Metadata-based (agent discovers) | Agent selection | Automatic |
| **Internal organization** | ✅ Via file references | ✅✅ Progressive disclosure (scripts/, references/, assets/) | ⚠️ Limited (single file) | ✅ Via file references |
| **Discrete sub-instructions** | ✅ Reference snippets | ✅✅ Separate files by responsibility | ⚠️ Markdown sections only | ✅ Reference separate files |
| **Scripts/executables** | ❌ No | ✅ scripts/ directory | ❌ No | ❌ No |
| **Reference documentation** | ✅ Via markdown links | ✅ references/ directory | ⚠️ Can reference prompts | ✅ Via markdown links |
| **Templates/assets** | ✅ Via file references | ✅ assets/ directory | ❌ No | ✅ Via file references |
| **Progressive disclosure** | ❌ All loaded at once | ✅✅ Three-level loading | ❌ Loaded when selected | ❌ All loaded at once |
| **Context efficiency** | ⚠️ Moderate | ✅✅ Excellent | ⚠️ Moderate | ⚠️ Low (always-on) |
| **Composability** | ✅ Reference other files | ✅✅ Reference scripts/docs | ✅✅ Use skills & prompts | ⚠️ Limited |
| **Tool specification** | ❌ No | ❌ No (agent-provided) | ✅ Via tools field | ❌ No |
| **MCP integration** | ❌ No | ❌ No | ✅ Via mcp-servers field | ⚠️ Can document MCP usage |
| **Handoffs** | ❌ No | ❌ No | ✅ Via handoffs field | ❌ No |
| **Best for** | Specific task workflows | Reusable specialized capabilities | Complex multi-agent orchestration | Universal project context |
| **Use case example** | "Unit test generator" | "Multi-phase analysis workflow" | "CI debugger agent" | "Repository standards" |
| **Status** | Public preview | General availability | General availability | General availability |

**Key insights:**

**Most flexible internal organization:** Skills (agentskills.io)
- Three-level progressive disclosure
- Separate directories for scripts, references, assets
- Best for complex workflows with discrete responsibilities
- Example: Analyze (instructions) → Collate (instructions) → Report (instructions) with separate reference docs for each phase

**Best for composition:** Custom Agents
- Can orchestrate multiple skills
- Can hand off between agents
- Can specify exact tools and MCP servers
- But limited internal structure (single file)

**Best for simple tasks:** Custom Prompts
- Lightweight single-file approach
- Can reference snippets for reuse
- User-controlled invocation
- But not portable, not auto-discovered

**Best for universal context:** CLAUDE.md / AGENTS.md
- Always loaded
- Can reference other files
- Good entry point pattern
- But context-inefficient for large projects

**Recommendation for discrete workflows (analyze, collate, report):**
1. **Use Skills** if you need:
   - Portable solution across platforms
   - Progressive context loading
   - Discrete instructions for each phase in separate reference files
   - Each responsibility isolated with its own rules and context
   - Auto-discovery by agent

2. **Use Custom Agent** if you need:
   - Orchestration of multiple skills
   - Specific tool/MCP configurations
   - Handoffs between specialized agents
   - GitHub Copilot-specific features

3. **Use Custom Prompts** if you need:
   - Simple user-invoked workflow
   - GitHub Copilot only
   - No auto-discovery needed
   - Lightweight implementation

4. **Use CLAUDE.md** if you need:
   - Always-available context
   - Entry point to other documentation
   - Claude Code specific

**Sources:**
- All previous findings synthesized with comparison analysis

---

## FINDING-2026-02-17-14
**Captured:** 2026-02-17
**Source:** Analysis refinement based on instruction-based workflow pattern

**Skills: Instruction-Based Discrete Task Pattern**

Skills are optimally structured for discrete instruction-based tasks (not just executable scripts).

**Pattern for multi-phase workflows (e.g., Analyze → Collate → Report):**

```
workflow-skill/
├── SKILL.md                      # Workflow orchestration
├── references/
│   ├── phase1-analyze.md         # Discrete analysis instructions
│   ├── phase2-collate.md         # Discrete collation instructions  
│   └── phase3-report.md          # Discrete reporting instructions
├── templates/
│   └── report-template.md        # Output format
└── scripts/                      # Optional automation helpers
```

**SKILL.md orchestrates the phases:**
```markdown
---
name: data-workflow
description: Multi-phase data analysis workflow with analyze, collate, report phases
---

# Data Analysis Workflow

## Phase 1: Analysis
See [analysis instructions](references/phase1-analyze.md) for:
- Data validation rules
- Statistical methods to apply
- Edge cases to handle

## Phase 2: Collation
See [collation instructions](references/phase2-collate.md) for:
- How to combine results
- Deduplication rules
- Aggregation methods

## Phase 3: Reporting
See [reporting instructions](references/phase3-report.md) for:
- Report structure requirements
- Visualization guidelines
- Summary generation rules

Use [report template](templates/report-template.md) for output format.
```

**Each phase file contains discrete, self-contained instructions:**

**references/phase1-analyze.md:**
```markdown
# Analysis Phase Instructions

## Your Role
Data analyst performing initial data examination.

## Input
Raw dataset from user (CSV, JSON, or database query result).

## Tasks
1. Validate data structure matches expected schema
2. Check for missing values and document
3. Identify outliers using IQR method
4. Calculate descriptive statistics (mean, median, std dev)
5. Note any data quality issues

## Rules
- Flag any row with >20% missing values
- Use IQR multiplier of 1.5 for outlier detection
- Document all assumptions made

## Output
Analysis summary with:
- Data quality report
- Outlier list with justification
- Descriptive statistics table
```

**references/phase2-collate.md:**
```markdown
# Collation Phase Instructions

## Your Role
Data aggregator combining analysis results.

## Input
Analysis summaries from Phase 1.

## Tasks
1. Combine statistics from all datasets
2. Deduplicate flagged issues
3. Aggregate outliers by category
4. Calculate cross-dataset metrics

## Rules
- Use weighted average for combined statistics
- Report conflicts if datasets disagree on schema
- Preserve original outlier counts before aggregation

## Output
Collated dataset with:
- Combined statistics
- Deduplicated issue list
- Cross-dataset comparison
```

**references/phase3-report.md:**
```markdown
# Reporting Phase Instructions

## Your Role
Report generator creating executive summary.

## Input
Collated results from Phase 2.

## Tasks
1. Generate summary of key findings
2. Create visualizations (describe what to plot)
3. Highlight critical issues
4. Provide recommendations

## Rules
- Lead with most important finding
- Maximum 3 recommendations
- Flag issues requiring immediate action
- Use template format from templates/report-template.md

## Output Format
Executive report following template structure.
```

**Benefits of this pattern:**

1. **Separation of concerns:** Each phase has isolated, focused instructions
2. **Progressive disclosure:** Agent only loads phase instructions when needed
3. **Reusability:** Individual phases can be referenced by other skills
4. **Clarity:** Each team member can own/review specific phase documentation
5. **Maintainability:** Update one phase without affecting others
6. **Context efficiency:** Only ~1000-2000 tokens per phase loaded when needed vs loading entire workflow

**Comparison to script-based approach:**

| Aspect | Instruction-based (references/) | Script-based (scripts/) |
|--------|--------------------------------|------------------------|
| **Execution** | Agent follows instructions | Agent runs code |
| **Flexibility** | High - agent adapts to context | Low - code is fixed |
| **Debugging** | Review instructions | Debug code |
| **Maintenance** | Update markdown | Update and test code |
| **Context usage** | Instructions loaded as text | Code + libraries + documentation |
| **Best for** | Cognitive tasks, analysis, writing | Deterministic tasks, calculations, automation |

**When to use scripts vs instructions:**
- **Use instructions** for: Analysis reasoning, content generation, decision-making workflows
- **Use scripts** for: Data transformation, file manipulation, deterministic calculations
- **Use both** for: Complex workflows where automation helps but judgment is needed

**Example combining both:**
```
skill/
├── SKILL.md
├── references/
│   ├── analyze-instructions.md    # How to reason about data
│   └── report-instructions.md     # How to structure findings
├── scripts/
│   └── calculate-stats.py         # Automated statistical calculations
└── templates/
    └── output.md
```

Agent follows instructions for reasoning, calls script for calculations.

**Sources:**
- Pattern derived from agentskills.io progressive disclosure design
- Best practices for instruction-based AI workflows
- Analysis of community skills repositories

---

## FINDING-2026-02-17-15
**Captured:** 2026-02-17
**Source:** Claude Code Official Documentation (code.claude.com), community analysis

**Claude Code Modes: Operational States vs Capability Packages**

Claude Code has **"modes"** which are fundamentally different from Skills and Copilot Agents. Modes are **operational states** that control how Claude behaves, not capability packages.

### Three Primary Modes

#### 1. Plan Mode

**What it is:** Read-only permission mode where Claude analyzes and plans without making changes.

**Characteristics:**
- **Permission-restricted:** Claude cannot edit files, write, or execute bash commands
- **Available tools:** Read, LS, Glob, Grep, Task, TodoRead/TodoWrite, WebFetch, WebSearch, NotebookRead
- **Restricted tools:** Edit/MultiEdit, Write, Bash, NotebookEdit, MCP tools that modify state
- **Output:** Creates `plan.md` files with structured plans
- **Activation:** 
  - During session: Shift+Tab to cycle through modes
  - CLI: `claude --permission-mode plan`
  - Default: Set in `.claude/settings.json` with `"defaultMode": "plan"`

**Use cases:**
- Exploring codebases safely
- Planning complex changes before execution
- Code review without modifications
- Analyzing authentication systems, refactoring strategies
- Getting consistently formatted suggestions

**Workflow:**
1. User describes task
2. Claude asks clarifying questions (especially with Opus 4.6)
3. Claude creates `plan.md` with task breakdown, dependencies, execution order
4. User reviews and edits plan (Ctrl+G to open in editor)
5. Claude executes approved plan (exits plan mode)

**Enhanced with Opus 4.6:**
- 1M context window for analyzing large codebases
- Adaptive thinking (decides when extended reasoning helps)
- Interactive clarifying questions upfront
- Editable plan.md files

**Key benefit:** Predictable, structured output; fast iteration; security (no accidental changes)

---

#### 2. Thinking Mode

**What it is:** Extended reasoning capability where Claude uses additional tokens for internal deliberation.

**Characteristics:**
- **Token budget:** Up to 31,999 tokens for internal reasoning (Claude 3.7/4.x)
- **Can scale to:** 64k thinking budget (Claude 3.7 Sonnet with configuration)
- **Output:** Creates `thinking` content blocks showing internal reasoning process
- **Visibility:** Thought process visible in raw form (research preview)
- **Activation levels:**
  - Low: Triggered by "think"
  - Medium: Triggered by "think hard", "megathink"
  - Max: Triggered by "think harder", "ultrathink"
- **CLI:** `/t` command to toggle, or `-o thinking 1` flag
- **Configuration:** Can set thinking budget with `-o thinking_budget X`

**Use cases:**
- Complex problem-solving
- Multi-step reasoning tasks
- Debugging complex issues
- Tasks requiring deep analysis
- Improved instruction following

**Behavior with tool use:**
- Supports interleaved thinking (Claude 4 models)
- Can think between tool calls
- Makes sophisticated reasoning after receiving tool results
- Thinking blocks are cached (preserved across turns in Opus 4.5)

**Performance impact:**
- Significantly improved instruction following
- Better performance on difficult tasks
- Longer processing time
- Higher token usage

**Environment variable:** `CLAUDE_CODE_THINKING_MODE=disabled` to turn off by default

---

#### 3. Fast Mode

**What it is:** Lower-latency responses with higher cost for Opus 4.6.

**Characteristics:**
- **Same model quality:** No quality degradation
- **Lower latency:** Faster responses
- **Higher cost:**
  - Fast mode on Opus 4.6 (<200K context): $30/MTok input, $150/MTok output
  - Fast mode on Opus 4.6 (>200K context): $60/MTok input, $225/MTok output
- **Toggle:** Can be enabled/disabled per session
- **Requirement:** Must be enabled for organization

**vs Lower effort level:**
- **Fast mode:** Same quality, lower latency, higher cost
- **Lower effort level:** Less thinking time, faster responses, potentially lower quality on complex tasks

**Use cases:**
- Time-sensitive tasks
- When speed matters more than cost
- Iterative workflows where latency impacts productivity

**Status:** Research preview

---

### Other Permission Modes

**Auto-Accept Mode:** Indicated by `⏵⏵ accept edits on`
- Automatically accepts all edit operations
- No manual approval required
- High-trust "YOLO mode"

**Delegate Mode:** Active when agent teams are running
- Coordinates multiple agents
- Lead agent assigns subtasks

**Normal Mode:** Standard interactive mode
- Prompts for permission before sensitive operations
- Default mode for most users

---

### Fundamental Difference: Modes vs Skills vs Agents

| Aspect | Claude Code Modes | Skills (agentskills.io) | Copilot Agents (.agent.md) |
|--------|------------------|------------------------|---------------------------|
| **Type** | Operational state | Capability package | Persona/orchestration |
| **What it controls** | Permissions & behavior | Domain knowledge & workflows | Tool selection & coordination |
| **Scope** | Session-level | Task-level | Workflow-level |
| **Activation** | User switches mode | Agent loads when relevant | User selects agent |
| **Persistence** | Session setting | Stored on disk | Stored on disk |
| **Portability** | Claude Code only | Cross-platform | GitHub Copilot only |
| **Purpose** | Control HOW Claude operates | Define WHAT Claude can do | Define WHO Claude is & how it orchestrates |
| **Examples** | Plan, Thinking, Fast | Data analysis, PDF processing | CI debugger, architecture reviewer |
| **Composition** | Modes can be combined with skills | Skills can reference other skills | Agents can invoke skills |
| **Internal structure** | Settings/flags | Scripts, references, assets | Single file with sections |

---

### Composition Patterns

**Modes + Skills:**
- Use **Plan Mode** to analyze codebase using **data-analysis skill**
- Use **Thinking Mode** when **complex debugging skill** is invoked
- Use **Fast Mode** for quick iterations with **unit-testing skill**

**Modes are orthogonal to Skills:**
- Skills define capabilities and knowledge
- Modes define operational constraints
- You can use any skill in any mode (subject to permission restrictions)

**Example workflow:**
1. Start in **Plan Mode** (read-only)
2. Use **architecture-analysis skill** to examine system
3. Claude creates plan.md with suggestions
4. Switch to **Normal Mode** with **Thinking Mode** enabled
5. Use **refactoring skill** to implement changes
6. Thinking mode helps with complex decisions

---

**Key insights:**

**Modes are NOT:**
- Content/instruction packages like Skills
- Persona definitions like Copilot Agents
- Alternative to CLAUDE.md or custom prompts

**Modes ARE:**
- Runtime behavior controls
- Permission/safety mechanisms
- Performance/cost tradeoffs
- Reasoning depth settings

**Comparison to GitHub Copilot:**
GitHub Copilot does NOT have equivalent "modes" concept:
- No Plan Mode equivalent (can't restrict to read-only in same way)
- No Thinking Mode equivalent (models don't expose internal reasoning)
- No Fast Mode equivalent (no cost/latency tradeoff settings)
- GitHub Copilot has "Ask Mode" vs "Agent Mode" but these are different:
  - Ask Mode: Conversational support without workspace interaction
  - Agent Mode: Full workspace interaction with file edits
  - These are more like permission levels than operational modes

**Claude Code's modes provide:**
- Finer-grained control over agent behavior
- Safety mechanisms (Plan Mode for read-only exploration)
- Performance tuning (Fast Mode, Thinking Mode)
- Workflow flexibility (switch modes mid-session)

**Sources:**
- Claude Code Official Documentation: "Speed up responses with fast mode"
- Claude Code Documentation: "Common workflows" (Plan Mode section)
- Claude API Documentation: "Extended thinking tips", "Building with extended thinking"
- Anthropic News: "Claude's extended thinking"
- Community analysis: "What Actually Is Claude Code's Plan Mode?" by Armin Ronacher
- GitHub discussion: "Configuration and Documentation for Thinking Mode" (#7668)

---
