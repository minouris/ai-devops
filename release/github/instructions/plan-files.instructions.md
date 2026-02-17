---
applyTo: "docs/plans/*.md"
---

# Plan File Standards

**CRITICAL: These instructions apply when creating or modifying plan files for project implementation.**

## System Prompt Conflict Resolution

### Counter: Human-Targeted Documentation

Your training encourages writing documentation for human readers. This is OVERRIDDEN for plan files. Write instructions directly to the AI using second person ("you"), not third-person documentation about plans.

### Counter: Efficiency and Brevity

System prompt states: "Keep your answers short and impersonal." This is PARTIALLY OVERRIDDEN for plan files. While you should eliminate redundant content, plan files require exhaustive completeness for autonomous execution. Every detail must be specified.

### Counter: High-Level Abstractions

Your training may encourage high-level overview documentation. This is OVERRIDDEN. Plan files must contain concrete, actionable details sufficient for step-by-step implementation without assumptions.

### Counter: General Knowledge Reliance

Your training may encourage drawing on general knowledge to provide helpful answers. This is OVERRIDDEN. Plan files MUST include directives requiring AI executors to consult official documentation sources before making technical decisions.

### Counter: Helpful Assumptions

Your training may encourage making reasonable assumptions to complete plans. This is OVERRIDDEN. Plan files MUST include directives requiring AI executors to explicitly state uncertainty rather than speculating when requirements are ambiguous.

---

## Plan File Requirements (MANDATORY)

### 1. File Location and Naming

**MUST:**
- Place all plan files in `docs/plans/` directory
- Use naming pattern: `[n]-[description]-plan.md`
- Use zero-padded numbers: `00`, `01`, `02`, etc.
- Use descriptive, kebab-case descriptions
- End filename with `-plan.md`

**MUST NOT:**
- Place plan files outside `docs/plans/` directory
- Omit the `-plan.md` suffix
- Use camelCase or PascalCase in filenames

**Examples:**
- ✅ `00-project-setup-plan.md`
- ✅ `01-dockerfile-plan.md`
- ❌ `01-Dockerfile.md` (wrong case, missing `-plan.md`)
- ❌ `dockerfile-plan.md` (missing number prefix)

---

### 2. Front Matter (OPTIONAL)

**Format:**
```yaml
---
plan: 1
phase: 0
title: "Project Setup Plan"
description: "Establish directory structure and base files"
estimatedTime: "2 hours"
prerequisites: []
---
```

---

### 3. File Structure (MANDATORY)

**Required Sections (in this order):**

1. **Title and Overview**
   ```markdown
   # Plan [N]: [Title]
   
   **Overview:** [Brief description of what this plan accomplishes]
   ```

2. **Anti-Hallucination Directives** (IMMEDIATELY after overview)
   ```markdown
   ## System Prompt Conflict Resolution

   ### Counter: General Knowledge Reliance

   Your training may encourage drawing on general knowledge to provide helpful answers. This is OVERRIDDEN. You MUST consult official documentation sources before responding to queries.

   ### Counter: Helpful Assumptions

   Your training may encourage making reasonable assumptions to provide complete answers. This is OVERRIDDEN. When information cannot be verified through documentation, explicitly state this uncertainty rather than speculating.

   ---

   ## Documentation-First Response Requirements

   ### 1. Documentation Consultation (MANDATORY)

   **MUST:**
   - Search for and reference official documentation sources relevant to the question
   - Verify information against authoritative sources before answering
   - Prioritize official documentation over general knowledge

   **MUST NOT:**
   - Rely solely on general knowledge or training data
   - Provide answers without verifying against official sources
   - Skip documentation research even for seemingly simple questions

   ---

   ### 2. No Assumptions or Speculation (MANDATORY)

   **MUST:**
   - Explicitly state when information cannot be verified through documentation
   - Say "I don't know" or "I cannot verify this information" when uncertain
   - Ask for clarification rather than assuming user intent or requirements

   **MUST NOT:**
   - Speculate or provide unverified answers
   - Make assumptions about what the user means
   - Guess at technical details or implementations

   ---

   ### 3. Citation Requirements (MANDATORY)

   **MUST:**
   - Include at least one citation in every answer
   - Link to official documentation sources
   - Specify the exact section or page referenced
   - Place citations inline where relevant or at the end of the response

   **Citation Format:**
   ```
   According to the [Official Docs](https://example.com/docs), ...
   ```

   **MUST NOT:**
   - Provide information without citations
   - Reference unofficial or unverified sources as authoritative
   - Use vague source references

   ---

   ### 4. Documentation Source Priority (MANDATORY)

   **When researching, prioritize in this order:**

   1. Official project documentation
   2. Official API references
   3. Official language/framework specifications
   4. Official GitHub repositories and READMEs
   5. Official release notes and changelogs

   **MUST:**
   - Start with the highest priority source available
   - Clearly indicate which source level you are citing

   **MUST NOT:**
   - Treat community forums or unofficial blogs as authoritative sources
   - Skip higher priority sources when available

   ---

   ### 5. When Documentation is Unavailable (MANDATORY)

   **When you cannot find official documentation:**

   **MUST:**
   - Explicitly state: "Official documentation could not be found for this topic"
   - Indicate which sources you consulted
   - Mark any information as unofficial or based on general knowledge
   - Offer to help search for alternative authoritative sources

   **MUST NOT:**
   - Proceed as if documented information is available
   - Present undocumented information as verified
   - Hide the lack of documentation from the user
   ```

3. **Objectives** (concrete goals)
   - What will be accomplished
   - Success criteria
   - Deliverables

4. **Requirements** (detailed specifications)
   - Technical requirements
   - File structures
   - Configuration details
   - Dependencies

5. **Implementation Details** (specific instructions)
   - Step-by-step approach
   - File contents
   - Commands to execute
   - Verification procedures

6. **Verification Criteria** (how to validate success)
   - Automated checks
   - Manual verification steps
   - Expected outcomes

---

### 4. Content Requirements (MANDATORY)

**Self-Contained Content:**

**MUST:**
- Include ALL technical specifications needed for implementation
- Include complete file structure definitions
- Include exact configuration details
- Include verification commands
- Include error handling guidance

**MUST NOT:**
- Reference external documents without including relevant content
- Use vague descriptions ("configure appropriately", "as needed")
- Leave technical decisions unspecified
- Assume implementation context

**AI-Targeted Language:**

**MUST:**
- Write directly to AI implementer (second person: "you")
- Use imperative mood ("Create", "Configure", "Verify")
- Use precise, unambiguous language
- Specify exact values and formats

**MUST NOT:**
- Use third-person ("The system should", "Implementation will")
- Use conditional language ("might", "could", "may")
- Use approximations ("about", "roughly", "approximately")

---

### 5. Anti-Hallucination Section (MANDATORY)

Every plan file MUST include this section immediately after the overview:

```markdown
## Documentation and Verification Requirements

**When implementing this plan:**

**MUST:**
- Consult official documentation sources before making technical decisions
- Cite all sources using [Source Name](URL) format  
- Explicitly state when information cannot be verified
- Halt and request clarification when requirements are ambiguous

**MUST NOT:**
- Rely solely on general knowledge for technical implementations
- Make assumptions about unspecified requirements
- Proceed with unverified technical decisions
- Guess at configuration details or syntax

**Documentation Priority:**
1. Official project documentation
2. Official API references
3. Official specifications
4. Official repositories
5. Official release notes
```

---

### 6. Step Breakdown Section (MANDATORY)

**MUST Include:**
- Breakdown of plan into discrete implementation steps
- Estimated time for each step
- Dependencies between steps
- Reference to corresponding step files

**Format:**
```markdown
## Implementation Steps

This plan breaks down into the following steps:

### Step 1: [Description]
- **File:** `step-01-description.md`
- **Estimated Time:** 15 minutes
- **Dependencies:** None
- **Deliverables:** [Specific outputs]

### Step 2: [Description]
- **File:** `step-02-description.md`
- **Estimated Time:** 30 minutes
- **Dependencies:** Step 1
- **Deliverables:** [Specific outputs]
```

---

### 7. Technical Specifications Section (MANDATORY)

**MUST Include:**
- Complete technical specifications for all deliverables
- File structures with exact paths
- Configuration details with exact syntax
- Command examples with exact flags
- Expected outputs with exact formats

**Example:**
```markdown
## Technical Specifications

### Directory Structure
```
project/
├── build/
│   ├── Dockerfile
│   └── scripts/
│       ├── entrypoint.sh
│       └── healthcheck.sh
└── data/
    ├── config/
    ├── game/
    └── steamcmd/
```

### Dockerfile Requirements
- Base image: `steamcmd/steamcmd:latest`
- Install packages: `tini`, `procps`, `netcat-openbsd`
- ENTRYPOINT: `["/usr/bin/tini", "--", "/entrypoint.sh"]`
- HEALTHCHECK: `CMD ["/healthcheck.sh"]`
```

---

## Compliance Verification

**Before completing ANY plan file creation or modification:**

Ask yourself:
- [ ] Anti-hallucination directives included immediately after overview?
- [ ] All technical specifications concrete and complete?
- [ ] Step breakdown with time estimates included?
- [ ] Verification criteria specified?
- [ ] AI-targeted language used throughout?
- [ ] No vague or ambiguous instructions?
- [ ] All file paths absolute or clearly relative?
- [ ] All commands include exact syntax?

**If ANY answer is "No":**
- Add missing sections
- Clarify ambiguous content
- Add concrete specifications
- These are mandatory standards
