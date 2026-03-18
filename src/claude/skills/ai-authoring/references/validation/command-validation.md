# Command Validation

Validate command artifacts against the command structure rules.

---

## Structure Rules Reference

Read `src/claude/rules/command-structure.md` before proceeding. That file is the single source of truth for required command structure. All MUST and MUST NOT requirements in that file are the validation criteria.

---

## Validation Procedure

**Step 1: Read the structure rules**

Read `src/claude/rules/command-structure.md` in full. Its MUST and MUST NOT requirements are the checklist you will validate against.

**Step 2: Read the artifact**

Read the command file: `src/{platform}/commands/{name}.md`

**Step 3: Check each MUST requirement**

For each MUST requirement in the structure rules:
1. Check whether the artifact satisfies it
2. If satisfied: mark as pass
3. If not satisfied: record a violation with file path, line number (if applicable), the violated rule, and a suggested fix

**Step 4: Check each MUST NOT requirement**

For each MUST NOT requirement in the structure rules:
1. Check whether the artifact violates it
2. If not violated: mark as pass
3. If violated: record a violation with file path, line number, the violated rule, and a suggested fix

**Step 5: Run the Compliance Verification checklist**

Work through the Compliance Verification section of `src/claude/rules/command-structure.md` line by line. Each checklist item must be answered.

**Step 6: Report results**

Report all violations. If none found, confirm validation passed.

---

## MUST

- Read `src/claude/rules/command-structure.md` before validating
- Check every MUST and MUST NOT requirement
- Report violations with file path, line number, rule reference, and suggested fix

## MUST NOT

- Define validation criteria in this file (they belong in the structure rules)
- Mark validation as passed if any MUST requirement is unmet
