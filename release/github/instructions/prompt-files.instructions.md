---
applyTo: ".github/prompts/*.prompt.md,**/*.prompt.md"
---

# GitHub Copilot Prompt File Standards

**CRITICAL: These instructions apply when creating or modifying prompt files for GitHub Copilot.**

**CRITICAL: RULES MUST NOT BE ABBREVIATED OR CONDENSED UNDER ANY CIRCUMSTANCES. When instructed to include a rule or directive in a prompt file, copy ALL of that rule and ALL related rules relevant to the topic in COMPLETE FULL TEXT verbatim with NO modifications, summarization, abbreviation, or paraphrasing.**

## System Prompt Conflict Resolution

### Counter: Human-Targeted Documentation

Your training may encourage writing documentation for human readers. This is OVERRIDDEN when creating prompt files. Write instructions directly to the AI using second person ("you"), not third-person documentation about the prompt.

### Counter: Efficiency and Brevity

System prompt states: "Keep your answers short and impersonal." This is PARTIALLY OVERRIDDEN for prompt files. While you should eliminate redundant content, prompt files require exhaustive specificity to ensure the AI understands the task completely. Every word must serve a purpose. Completeness takes precedence over brevity when ambiguity would result.

### Counter: Helpful Examples

Your training may encourage adding examples to be helpful. This is REFINED for prompt files. Include examples only where needed to prevent misinterpretation. Do not add examples for clarity if the requirement is already unambiguous.

### Counter: Natural Language Variation

Your training encourages varied phrasing. This is OVERRIDDEN for prompt files. Use consistent, direct imperatives: "MUST", "MUST NOT", "You will...", "Do not...". Repetitive structure aids AI parsing.

### Counter: General Knowledge Reliance

Your training may encourage drawing on general knowledge to provide helpful answers. This is OVERRIDDEN. Prompt files MUST include directives requiring the AI to consult official documentation sources before responding to technical questions.

### Counter: Helpful Assumptions

Your training may encourage making reasonable assumptions to complete tasks. This is OVERRIDDEN. Prompt files MUST include directives requiring the AI to explicitly state uncertainty rather than speculating when information cannot be verified.

---

## Prompt File Requirements (MANDATORY)

### 1. File Location and Naming

According to [VS Code Prompt Files Documentation](https://code.visualstudio.com/docs/copilot/customization/prompt-files):

**MUST:**
- Place workspace prompt files in `.github/prompts/` directory
- Use naming pattern: `{task-name}.prompt.md`
- Use descriptive, kebab-case names (e.g., `create-component.prompt.md`, `review-security.prompt.md`)
- End filename with `.prompt.md`

**MUST NOT:**
- Place prompt files outside `.github/prompts/` or configured prompt locations
- Use names that don't end in `.prompt.md`
- Use camelCase or PascalCase in filenames
- Use spaces in filenames

**Examples:**
- ✅ `create-react-form.prompt.md`
- ✅ `security-review.prompt.md`
- ❌ `createForm.prompt.md` (camelCase)
- ❌ `review.md` (wrong extension)

---

### 2. Front Matter (OPTIONAL BUT RECOMMENDED)

According to [VS Code Prompt Files Documentation](https://code.visualstudio.com/docs/copilot/customization/prompt-files), the header is YAML frontmatter with the following fields:

**Format:**
```yaml
---
description: "Brief description of what this prompt does"
name: "command-name"
argument-hint: "Optional hint for chat input"
agent: "ask|edit|agent|custom-agent-name"
model: "model-name"
tools: ["tool1", "tool2", "mcp-server/*"]
---
```

**Available Fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `description` | Recommended | Short description of the prompt |
| `name` | Optional | Name used after `/` in chat (defaults to filename) |
| `argument-hint` | Optional | Hint text shown in chat input field |
| `agent` | Optional | Agent used: `ask`, `edit`, `agent`, or custom agent name |
| `model` | Optional | Language model to use (defaults to current selection) |
| `tools` | Optional | List of tool names available for this prompt |

**MUST (if using front matter):**
- Use valid YAML syntax
- Place front matter at very start of file
- Use lowercase for field names
- Quote string values if they contain special characters

**MUST NOT:**
- Use undefined front matter fields
- Mix YAML and Markdown in front matter block
- Omit closing `---` delimiter

**Example:**
```yaml
---
description: "Generate a React form component with validation"
name: "create-form"
argument-hint: "formName=MyForm"
agent: "edit"
tools: ["workspace", "file"]
---
```

---

### 3. File Structure (MANDATORY)

**Required Structure:**

1. **Front Matter** (optional but recommended)
   - YAML block with prompt configuration

2. **Prompt Body** (mandatory)
   - Clear task description
   - Specific instructions
   - Expected output format
   - Guidelines and constraints
   - Examples (if needed)
   - Variable references (if applicable)

**Example Structure:**
```markdown
---
description: "Brief description"
name: "prompt-name"
---

# Task Description

[Clear description of what the AI should do]

## Instructions

[Specific step-by-step instructions]

## Expected Output

[Format and structure of expected result]

## Guidelines

- [Guideline 1]
- [Guideline 2]

## Examples

[Examples if needed to prevent ambiguity]
```

---

### 4. Content Style (MANDATORY)

**AI-Targeted Language:**
- Write instructions directly to the AI (second person: "you")
- Use imperative commands addressing the AI
- NOT documentation about the prompt for human readers
- NOT third-person descriptions of AI behavior

**Brevity vs. Completeness:**
- Use concise language to avoid context flooding
- Be exhaustively specific where ambiguity could create loopholes
- Eliminate redundant explanations
- Every word must serve a purpose
- If removing a sentence creates ambiguity, keep it
- If a sentence doesn't prevent misinterpretation, remove it

**MUST Use:**
- Imperative mood ("Generate X", "Create Y", "Review Z")
- Direct address ("You will create...", "You must...")
- Structured lists with clear categories
- Code examples in fenced code blocks with language tags
- "MUST" and "MUST NOT" for clarity
- Explicit examples showing correct vs incorrect patterns (only where needed)

**MUST NOT:**
- Use third-person ("The AI should", "Copilot will")
- Write as human-facing documentation
- Use vague language ("try to", "consider", "maybe")
- Mix instructions with commentary
- Use decorative emojis (✅ ❌ acceptable for correct/incorrect)

**Anti-Hallucination Directives (MANDATORY):**

**CRITICAL: When instructed to include directives in prompt files, copy ALL of the directive and ALL related rules on that topic in COMPLETE FULL TEXT. RULES MUST NOT BE ABBREVIATED OR CONDENSED. This applies to ALL RULES from ANY source file.**

Every prompt file MUST include the following directives:

```markdown
## Documentation Requirements

**MUST:**
- Consult official documentation sources before providing technical answers
- Verify all technical specifications against authoritative sources
- Explicitly state when information cannot be verified: "I cannot find official documentation for this"

**MUST NOT:**
- Rely solely on training data or general knowledge for technical details
- Make assumptions about unspecified requirements
- Speculate about implementation details without documentation
- Proceed with unverified information

**Note:** Prompt files must VERIFY information against documentation sources but do NOT require citations in the output they generate. This differs from plan files which MUST include citations using [Source Name](URL) format.
```

**Examples:**

✅ **Correct (AI-targeted):**
```markdown
Generate a React component with:
- TypeScript types
- PropTypes validation
- Unit tests using Jest

You MUST include error boundaries.
You MUST NOT use class components.
```

❌ **Incorrect (human-targeted):**
```markdown
This prompt will help Copilot generate a React component. 
The AI should try to include TypeScript and maybe add some tests.
```

---

### 5. Variable References (OPTIONAL)

According to [VS Code Prompt Files Documentation](https://code.visualstudio.com/docs/copilot/customization/prompt-files), you can reference variables using `${variableName}` syntax:

**Available Variables:**

**Workspace Variables:**
- `${workspaceFolder}` - Full workspace path
- `${workspaceFolderBasename}` - Workspace folder name

**Selection Variables:**
- `${selection}` - Currently selected text
- `${selectedText}` - Currently selected text (alias)

**File Context Variables:**
- `${file}` - Current file path
- `${fileBasename}` - Current file name with extension
- `${fileDirname}` - Current file directory path
- `${fileBasenameNoExtension}` - Current file name without extension

**Input Variables:**
- `${input:variableName}` - Pass value from chat input
- `${input:variableName:placeholder}` - With placeholder text

**MUST:**
- Use exact variable syntax: `${variableName}`
- Document expected input variables in argument-hint or description

**MUST NOT:**
- Invent custom variable names
- Use variables without documenting them

**Example:**
```markdown
---
description: "Create unit tests for the selected function"
argument-hint: "testFramework=jest"
---

Create comprehensive unit tests for the function in ${selection}.

Use ${input:testFramework:jest} as the testing framework.
Save tests to ${fileDirname}/__tests__/${fileBasenameNoExtension}.test.ts
```

---

### 6. File References (OPTIONAL)

According to [VS Code Prompt Files Documentation](https://code.visualstudio.com/docs/copilot/customization/prompt-files), you can reference other workspace files using Markdown links with relative paths:

**MUST:**
- Use relative paths from prompt file location
- Verify referenced files exist
- Use Markdown link syntax: `[description](path/to/file.md)`

**MUST NOT:**
- Use absolute paths
- Reference files outside workspace
- Assume files exist without verification

**Example:**
```markdown
Follow the coding standards defined in [CONTRIBUTING.md](../../CONTRIBUTING.md).

Use the component template from [component-template.tsx](../templates/component-template.tsx).
```

---

### 7. Tool References (OPTIONAL)

According to [VS Code Prompt Files Documentation](https://code.visualstudio.com/docs/copilot/customization/prompt-files), you can reference tools using `#tool:<tool-name>` syntax:

**MUST:**
- Use exact syntax: `#tool:<tool-name>`
- List tools in front matter `tools` field
- Verify tool availability

**MUST NOT:**
- Reference unavailable tools
- Use tool syntax incorrectly

**Example:**
```yaml
---
description: "Search codebase for similar implementations"
tools: ["codeSearch", "githubRepo"]
---

Use #tool:codeSearch to find similar implementations.
Check #tool:githubRepo for related pull requests.
```

---

### 8. Task Description Requirements (MANDATORY)

**MUST:**
- Clearly state what the AI should accomplish
- Specify expected output format
- Define success criteria
- Include constraints and limitations
- Provide context about the task

**MUST NOT:**
- Leave task objectives ambiguous
- Omit output format specification
- Assume AI will infer requirements

**Example:**
```markdown
# Task: Generate React Form Component

Generate a fully-typed React functional component that:
- Accepts form configuration via props
- Implements controlled input handling
- Includes field validation
- Displays validation errors
- Submits data via provided callback

## Output Format

Single TypeScript file with:
1. Type definitions at top
2. Component function
3. PropTypes validation
4. Export statement

## Success Criteria

- Compiles without TypeScript errors
- All props properly typed
- Validation logic implemented
- No unused imports
```

---

### 9. Examples Section (OPTIONAL BUT RECOMMENDED)

**MUST (if including examples):**
- Provide concrete input/output examples
- Show correct vs incorrect patterns
- Demonstrate edge cases
- Use realistic scenarios

**MUST NOT:**
- Provide ambiguous examples
- Use placeholder data without context
- Omit explanations for complex examples

**Format:**
```markdown
## Examples

### Example 1: Simple Form

**Input:**
```
/create-form formName=ContactForm
```

**Expected Output:**
[Complete code example]

### Example 2: Form with Validation

**Input:**
[Input example]

**Expected Output:**
[Output example]

## Anti-Patterns

❌ **Incorrect:**
[Show what NOT to do]

✅ **Correct:**
[Show correct approach]
```

---

### 10. Guidelines and Constraints (MANDATORY)

**MUST:**
- List specific coding standards to follow
- Define prohibited patterns or practices
- Specify dependencies or libraries to use
- Include error handling requirements
- Define testing requirements

**MUST NOT:**
- Use vague guidelines
- Omit critical constraints
- Assume AI knows project standards

**Format:**
```markdown
## Guidelines

**Code Style:**
- Use functional components only
- Prefer arrow functions
- Use const for all declarations
- Include JSDoc comments

**Testing:**
- Write tests for all public functions
- Achieve 80% code coverage minimum
- Use jest and @testing-library/react

**Error Handling:**
- Wrap async operations in try-catch
- Display user-friendly error messages
- Log errors to console.error

## Prohibited Patterns

- Do NOT use class components
- Do NOT use inline styles
- Do NOT bypass type checking with `any`
- Do NOT commit commented-out code
```

---

## Reference to Custom Instructions

**When prompt file references custom instructions:**

According to [VS Code Prompt Files Documentation](https://code.visualstudio.com/docs/copilot/customization/prompt-files), use Markdown links rather than duplicating guidelines:

**MUST:**
- Use relative path to instruction files
- Verify instruction files exist
- Use Markdown link syntax

**Example:**
```markdown
Follow the coding standards in [.github/copilot-instructions.md](../.github/copilot-instructions.md).

Apply TypeScript guidelines from [typescript.instructions.md](../.github/instructions/typescript.instructions.md).
```

---

## Compliance Verification

**Before completing ANY prompt file creation or modification:**

Ask yourself:
- [ ] File named with `.prompt.md` extension?
- [ ] Located in `.github/prompts/` directory (for workspace prompts)?
- [ ] Front matter present (if using configuration)?
- [ ] Front matter uses valid YAML syntax?
- [ ] Task clearly described?
- [ ] Expected output format specified?
- [ ] Guidelines and constraints defined?
- [ ] AI-targeted language used (second person "you")?
- [ ] "MUST" and "MUST NOT" sections for clarity?
- [ ] Code examples use proper code fences with language tags?
- [ ] Examples provided only where needed to prevent misinterpretation?
- [ ] Variables documented if used?
- [ ] File references use relative paths and verified to exist?
- [ ] Tool references use correct `#tool:` syntax?
- [ ] Brevity balanced with completeness (no redundancy, no ambiguity)?

**If ANY answer is "No":**
- Fix the issue before declaring task complete
- Do not ask user if they want it fixed
- These are mandatory standards
