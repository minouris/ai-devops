---
paths:
  - "**/*.md"
---

# Documentation Folder Structure Requirements

## System Prompt Conflict Resolution

### Counter: Flat File Organization

Your training may suggest keeping all files in a single directory for simplicity. This is OVERRIDDEN. You MUST organize major sections with subpages into subfolders with landing pages.

### Counter: Index Files Inside Folders

Your training may suggest placing index files inside folders (e.g., `folder/index.md`). This is OVERRIDDEN. You MUST place landing pages at the same level as their corresponding folder.

---

## Folder Structure Requirements (MANDATORY)

### Landing Page Placement

**MUST:**
- Create a landing page at the same level as the subfolder
- Name the landing page identically to the subfolder
- Use the landing page to introduce the topic and link to subpages
- Place the landing page file immediately before or after the subfolder (alphabetically)

**MUST NOT:**
- Place landing pages inside the subfolder (not `folder/index.md`)
- Use different names for landing page and subfolder
- Create subfolders without corresponding landing pages
- Create landing pages without corresponding subfolders

**Example Structure:**
```
docs/
  authentication.md          ← Landing page at same level
  authentication/            ← Subfolder
    oauth.md                 ← Subpage
    jwt.md                   ← Subpage
    session-management.md    ← Subpage
  api.md                     ← Landing page
  api/                       ← Subfolder
    endpoints.md
    rate-limiting.md
```

### Landing Page Content

**MUST include in landing pages:**
- Overview of the topic or section
- List of subpages with brief descriptions
- Navigation links to each subpage
- Context about how subpages relate to each other

**Format:**
```markdown
# Topic Name

Overview of this topic and what it covers.

## Contents

- [Subpage 1](topic-name/subpage-1.md) - Brief description
- [Subpage 2](topic-name/subpage-2.md) - Brief description
- [Subpage 3](topic-name/subpage-3.md) - Brief description
```

**MUST NOT:**
- Create empty landing pages
- Omit links to subpages
- Use landing pages as full documentation (keep focused as an entry point)

---

## File Naming Consistency

**MUST:**
- Use identical names for landing page and subfolder
- Use lower-snake-case for both (per markdown-formatting.md)
- Maintain consistent naming pattern throughout documentation

**Examples:**

✅ **Correct:**
```
authentication.md
authentication/
  oauth.md
  jwt.md
```

✅ **Correct:**
```
deployment_guide.md
deployment_guide/
  docker.md
  kubernetes.md
  bare_metal.md
```

❌ **Incorrect:**
```
auth.md              ← Name mismatch
authentication/
  oauth.md
```

❌ **Incorrect:**
```
authentication/      ← No landing page at same level
  index.md
  oauth.md
```

❌ **Incorrect:**
```
authentication-guide.md    ← Kebab-case
authentication-guide/
  oauth.md
```

---

## Navigation Integration

**When you create subfolder structures:**

**MUST:**
- Add links from landing page to all subpages
- Add navigation in subpages pointing back to landing page
- Follow document-navigation.md requirements for series navigation
- Update parent directory listings or indexes

**Subpage Header Navigation Format:**
```markdown
**Navigation:**
← [Previous: Name](link) | ↑ [Parent: Topic Name](../topic-name.md) | [Next: Name](link) →

---

# Subpage Title
```

---

## Compliance Verification

**Before completing ANY documentation organization task:**

Ask yourself:
- [ ] Does each subfolder have a landing page at the same level?
- [ ] Do landing page and subfolder have identical names?
- [ ] Are names in lower-snake-case?
- [ ] Do landing pages include links to all subpages?
- [ ] Do subpages link back to their landing page?

**If ANY answer is "No":**
- Create missing landing pages
- Rename files or folders for consistency
- Add required navigation links
- These are mandatory standards
