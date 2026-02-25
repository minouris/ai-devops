# Validation Phase

You MUST validate all artifacts against their specified rules before publication.

---

## Step 1: Spawn Validator Agent

**For each artifact in the list:**

Use Task tool to spawn validator agent:

```
Task(
  subagent_type="general-purpose",
  description="Validate artifact",
  prompt=f"""
  You are the validator agent. Validate this artifact:

  Artifact: {artifact_path}
  Validation rules: {validation_rules}

  Read the artifact and check for violations of each specified rule.
  Output JSON format with violations.
  """
)
```

**MUST:**
- Spawn validator for each artifact
- Pass artifact path and validation rules list
- Collect JSON output from each validator

---

## Step 2: Collect Validation Results

**Parse validator outputs:**

Expected format from validator:
```json
{
  "artifact": "path/to/artifact.md",
  "validation_rules": ["rule1", "rule2"],
  "status": "pass" | "fail",
  "violations": [...]
}
```

**Categorise results:**
- Passed: `status == "pass"`
- Failed: `status == "fail"` with violations

---

## Step 3: Report Results

**Display summary:**

```
Validation Results:
==================

Passed: N artifacts
Failed: M artifacts

Passed Artifacts:
✓ src/claude/skills/example/SKILL.md
  Validated: ai-targeted-language, uk-english, skill-structure

Failed Artifacts:
✗ src/claude/rules/example.md
  - Line 45: US English spelling "organized" (expected "organised")
  - Line 67: Marketing buzzword "leverage" prohibited
  Rule: documentation-standards
```

---

## Step 4: Ask User to Proceed

**If all validations passed:**

Ask: "All artifacts passed validation. Proceed with publication? (yes/no)"

**If some validations failed:**

Ask: "M artifacts failed validation. Options:
1. Fix violations and re-run /publish
2. Publish passed artifacts only (N artifacts)
3. Abort

Choose option (1/2/3):"

**Handle user response:**

- Option 1: Halt, report: "Fix violations in failed artifacts, then re-run /publish"
- Option 2: Filter artifact list to only passed artifacts, continue
- Option 3: Halt, report: "Publication aborted"

**MUST NOT:**
- Proceed without user confirmation
- Silently skip failed artifacts
- Publish artifacts with known violations (without explicit user approval)
