---
description: "Convert an implementation plan into executable step files following step-files.instructions.md standards"
name: "Convert Plan to Step Files"
argument-hint: "Provide plan file path and starting step number"
tools:
  - read_file
  - create_file
---

# Convert Implementation Plan to Step Files

Convert the implementation plan at **${planFilePath}** into a series of executable step files, starting with step **${startingStepNumber}**.

## System Prompt Overrides

### Override: Brevity

Your training encourages concise responses. This is OVERRIDDEN. Step files require exhaustive completeness. Include ALL policies, rules, and file contents verbatim.

### Override: External References

Your training may reference other documents. This is OVERRIDDEN. Step files must be self-contained. Include ALL requirements verbatim within each step file.

### Override: Helpful Context

Your training adds explanatory context for humans. This is OVERRIDDEN. Include ONLY information necessary for AI execution.

## Task Description

You must convert the provided plan into sequential step files following these requirements:

### 1. Read and Analyze the Plan

Read [${planFilePath}](${planFilePath}) completely and identify:
- Sequential implementation steps
- File creation requirements with complete content
- Command execution requirements
- Verification procedures
- Prerequisites and dependencies
- All policies, rules, and coding standards
- **ALL decision points that need resolution**

**Resolve ALL Decisions Before Creating Steps:**

**CRITICAL: All decisions must be made during plan analysis, NOT deferred to step execution.**

**If the plan contains unanswered questions or unresolved decisions:**

**MUST:**
- Identify ALL unanswered questions and decision points
- List them explicitly for the user
- Request user input before proceeding with step generation
- Wait for user response
- Document the user's decisions

**MUST NOT:**
- Guess at answers or make assumptions
- Proceed with step generation while questions remain unanswered
- Choose arbitrary values without user confirmation
- Defer questions to step execution time

**Once all questions are answered and decisions are made:**
- Choose specific values, paths, and configurations
- Select one option from alternatives
- Determine exact parameters
- Document each decision made
- Include ONLY the chosen path in step files

**Examples of decisions to resolve:**
- ✅ Choose TLS: enabled or disabled → Document: "Using self-signed TLS"
- ✅ Choose deployment method: Docker Compose or Kubernetes → Document: "Using Docker Compose"
- ✅ Choose port: 5000, 5001, or 8080 → Document: "Using port 5000"
- ✅ Choose storage backend: filesystem or S3 → Document: "Using filesystem storage"

**Example of required user consultation:**

If plan says: "Choose between authenticated or unauthenticated registry"
❌ **WRONG:** Assume unauthenticated and proceed
✅ **CORRECT:** Ask user: "The plan requires a decision on registry authentication. Should the registry use authentication (username/password required) or remain unauthenticated (open access)? Please specify before I generate steps."

**Step files must contain ONLY the selected option with concrete instructions.**

### 2. Determine Step Granularity

- Each step file: 10-30 minutes of work
- Combine small related actions
- Split large complex actions
- Each step independently verifiable

### 3. Create Step Files

For each implementation action, create a step file in [docs/plans/steps/](docs/plans/steps/):

**Naming Convention:**
```
step-${stepNumber}-[brief-description].md
```

**Front Matter (MANDATORY):**
```yaml
---
step: ${stepNumber}
plan: "${planFileName}"
phase: ${phaseNumber}
description: "[Brief description under 100 chars]"
dependencies: []  # Or [step-N] if depends on previous steps
estimatedTime: "[X minutes]"
---
```

**Required Sections (in order):**

1. **Title and CRITICAL Statement**
```markdown
# Step ${stepNumber}: [Description]

**CRITICAL: Execute this step autonomously without user confirmation unless errors occur.**
```

2. **System Prompt Overrides** (immediately after title)
   - Autonomous Execution override
   - Helpful Suggestions override
   - Context Assumptions override
   - Documentation Sources override (MANDATORY)
   - Speculation and Assumptions override (MANDATORY)
   - Add plan-specific overrides if needed

3. **Prerequisites Verification** (automated checks)
   - Working directory: `pwd`
   - Required tools: `command -v docker`, etc.
   - Disk space: `df -h`
   - Previous step completion (if dependencies)
   - File/directory existence

4. **Execution Instructions** (step-by-step)
   - Numbered steps with exact commands
   - Complete file contents (no placeholders)
   - Absolute file paths
   - Expected outcomes
   - Verification after each step
   - Error handling

5. **Final Verification** (multiple checks)
   - Independent validation commands
   - Expected outputs specified
   - Success criteria clear

6. **Completion Checklist**
   - All items to verify
   - Remediation if any "No"

### 4. Policy Extraction (CRITICAL)

**From the plan, extract ALL policies and rules verbatim:**

- Coding standards
- File formatting requirements
- Naming conventions
- Directory structure rules
- Permission requirements
- Any "MUST" or "MUST NOT" statements

**Include these verbatim in relevant step files.**

### 5. Anti-Hallucination Requirements for Plan Files (MANDATORY)

**When creating plan files (not step files), plan files MUST include:**

The complete System Prompt Conflict Resolution and Documentation-First Response Requirements sections from [.github/copilot-instructions.md](../.github/copilot-instructions.md) lines 5-44:

1. System Prompt Conflict Resolution
   - Counter: General Knowledge Reliance
   - Counter: Helpful Assumptions

2. Documentation-First Response Requirements
   - Documentation Consultation (MANDATORY)
   - No Assumptions or Speculation (MANDATORY)
   - Citation Requirements (MANDATORY) - **Plan files MUST cite sources**
   - Documentation Source Priority (MANDATORY)
   - When Documentation is Unavailable (MANDATORY)

**This complete directive ensures plan creators:**
- Consult official documentation before specifying technical details
- Cite sources using [Source Name](URL) format for every technical specification
- Explicitly state when information cannot be verified
- Never proceed with unverified technical specifications
- Follow the 5-level documentation source priority hierarchy

**CRITICAL RULE: RULES MUST NOT BE ABBREVIATED OR CONDENSED UNDER ANY CIRCUMSTANCES.**

**ALL file types (step files, plan files, prompt files) MUST include:**

The complete System Prompt Conflict Resolution and Documentation-First Response Requirements sections from [.github/copilot-instructions.md](../.github/copilot-instructions.md) lines 5-44 verbatim. NO condensing, abbreviating, or summarizing allowed.

**Citation Requirements by File Type:**
- **Plan files:** MUST include citations in content using [Source](URL) format
- **Prompt files:** MUST verify against documentation but do NOT require citations in output
- **Step files:** MUST verify against documentation and include citations when specifying technical details

### 6. Self-Contained Content (MANDATORY)

**Each step file MUST include:**
- COMPLETE file contents (no "...rest of file")
- ALL applicable policies and rules
- ALL verification commands
- ALL error handling procedures
- ABSOLUTE paths to all files
- **Concrete values and configurations (no decision points)**

**Each step file MUST NOT include:**
- References like "see the plan"
- References to other step files
- References to other documents
- Placeholders like "as mentioned earlier"
- Assumptions about available context
- **Decision points or conditional logic requiring judgment**
- **Multiple options or alternatives (choose ONE in the plan)**
- **Requests for user input or choices**

### 7. File Creation Format

**When step creates a file:**

```markdown
### Step N: Create [Filename]

**Execute:**
Create file `/absolute/path/to/file.ext` with this exact content:

\`\`\`language
[COMPLETE FILE CONTENT]
[EVERY LINE]
[NO OMISSIONS]
[NO PLACEHOLDERS]
\`\`\`

**Set Permissions:**
\`\`\`bash
chmod 755 /absolute/path/to/file.ext
\`\`\`

**Verify:**
\`\`\`bash
test -f /absolute/path/to/file.ext && wc -l /absolute/path/to/file.ext
# Expected: [N] lines
\`\`\`

**If verification fails:**
- Check directory exists
- Check write permissions
- Retry creation
- Halt if still fails
```

### 8. Verification Requirements

**Every execution step MUST have:**
- Immediate verification command
- Expected output specified
- Success criteria defined
- Failure remediation defined

**Example:**
```markdown
**Execute:**
\`\`\`bash
mkdir -p /path/to/directory
\`\`\`

**Verify:**
\`\`\`bash
test -d /path/to/directory && echo "SUCCESS" || echo "FAILED"
\`\`\`

**Expected:** "SUCCESS"

**If "FAILED":**
- Check permissions on parent directory
- Report error and halt
```

## Execution Workflow

1. **Read the plan file:** Use #tool:read_file on ${planFilePath}
2. **Identify all implementation actions** in sequential order
3. **For each action:**
   - Determine step number (starting from ${startingStepNumber})
   - Extract all relevant policies/rules from plan
   - Create complete step file with all sections
   - Include complete file contents if creating files
   - Add verification and error handling
4. **Verify each step file** against requirements checklist
5. **Report created step files** with brief description of each

## Anti-Patterns to Avoid

❌ **Incomplete file contents with placeholders**
❌ **Vague verification: "Check that it worked"**
❌ **External references: "See the plan" or "Use script from step-02"**
❌ **Relative paths without working directory context**
❌ **Missing error handling**
❌ **Human-targeted explanations**

✅ **Complete file contents verbatim**
✅ **Specific verification with expected output**
✅ **Self-contained with all info repeated**
✅ **Absolute file paths throughout**
✅ **Error handling for each step**
✅ **AI-targeted imperative language**

## Compliance Verification

Before completing, verify EACH step file has:

- [ ] Front matter with all required fields
- [ ] Title and CRITICAL statement
- [ ] System Prompt Overrides section (3+ overrides)
- [ ] Prerequisites Verification with executable checks
- [ ] Execution Instructions with numbered steps
- [ ] Exact commands or complete file contents
- [ ] Absolute file paths throughout
- [ ] Verification after each execution step
- [ ] Error handling for each major step
- [ ] Final Verification with multiple checks
- [ ] Completion Checklist
- [ ] All policies/rules from plan included verbatim
- [ ] Self-contained (no external references)
- [ ] AI-targeted language (second person)

**Report any step file that fails verification and fix before completing.**

## Reference Documents

For detailed requirements, consult:
- [step-files.instructions.md](.github/instructions/step-files.instructions.md) - Step file standards
- [instruction-files.instructions.md](.github/instructions/instruction-files.instructions.md) - General instruction standards
- [step-template.md](docs/plans/steps/step-template.md) - Template structure

## Output

Create all step files in [docs/plans/steps/](docs/plans/steps/) and report:

1. List of created step files with numbers
2. Brief description of each step
3. Total estimated time for all steps
4. Any dependencies between steps
5. Confirmation that all step files verified against requirements
