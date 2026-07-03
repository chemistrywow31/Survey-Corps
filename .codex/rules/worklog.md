---
name: Worklog
description: Defines the worklog structure and evidence chain requirements for all market research tasks
---

# Worklog

## Applicability

- Applies to: All agents (every agent must read from and write to the worklog during task execution)

## Rule Content

### Every Task Must Have a Worklog

Every market research project must maintain a worklog under the `.worklog/` directory. The worklog records reference information, key findings, and decision rationale for each phase.

### Directory Structure

```
.worklog/{yyyymm}/{project-name}/phase-{n}-{label}/
  ├── references.md
  ├── findings.md
  └── decisions.md
```

- `{yyyymm}`: Year-month of project start (e.g., `202604`)
- `{project-name}`: kebab-case (e.g., `ai-chatbot-feasibility`)
- `phase-{n}-{label}`: numbered sequentially (e.g., `phase-1-intake`, `phase-2-data-collection`)

### Required Files Per Phase

#### references.md

Record all information sources consulted: URLs, Source Registry entries, user statements, and internal documents referenced. Each reference must include: source identifier, brief description, and how it was used.

#### findings.md

Record key discoveries derived from the references: facts established, patterns identified, constraints discovered, and comparative analysis results. Each finding must trace back to at least one entry in `references.md`.

#### decisions.md

Record every decision made: the decision statement, rationale, alternatives considered, supporting evidence (references to `findings.md` and `references.md`), and downstream impact.

### Evidence Chain Requirement

The three files form an evidence chain: **references → findings → decisions**. Every decision must trace back through findings to references. A decision with no traceable evidence chain is a violation.

### Worklog as Context Offloading

Once information is written to the worklog, agents do not need to retain it in context. Downstream agents read upstream phase worklogs instead of receiving full context in the task dispatch.

## Violation Determination

- Project completes a phase with no corresponding worklog directory → Violation
- Phase worklog missing any of the three core files → Violation
- `decisions.md` contains a decision with no traceable evidence → Violation
- `findings.md` contains a finding with no source reference → Violation

## Exceptions

- Phases that produce no decisions (e.g., Phase 1 intake collects user input only) may have an empty `decisions.md` with a note: "No decisions made in this phase — input collection only."
