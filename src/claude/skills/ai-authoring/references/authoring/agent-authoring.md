# Agent Authoring

Guide creation of agent artifacts using the agent structure rules as the authoritative definition of required structure.

---

## Structure Rules Reference

Read `src/claude/rules/agent-structure.md` before proceeding. That file is the single source of truth for required agent structure. All MUST and MUST NOT requirements in that file apply during authoring.

---

## Authoring Procedure

**Step 1: Read the structure rules**

Read `src/claude/rules/agent-structure.md` in full. Use its MUST requirements as your checklist for what to create.

**Step 2: Create required files**

For each MUST requirement in the structure rules:
1. Create the required file or section
2. Show the user what you have created
3. Explain which requirement it satisfies

**Step 3: Enforce requirements interactively**

As the user provides content:
- Check each piece of content against the MUST requirements in the structure rules
- Flag any MUST NOT violations immediately with the specific rule and a suggested fix
- Do not proceed to the next element until the current one satisfies its requirements

**Step 4: Run the Compliance Verification checklist**

When all files are created, work through the Compliance Verification section of `src/claude/rules/agent-structure.md` line by line. Report each item as pass or fail. Fix any failures before marking authoring complete.

---

## MUST

- Read `src/claude/rules/agent-structure.md` before starting authoring
- Use the structure rules MUST checklist to confirm completeness
- Flag MUST NOT violations immediately

## MUST NOT

- Define structure requirements in this file (they belong in the structure rules)
- Mark authoring complete before the Compliance Verification checklist passes
