# Market Research Team

## Team Objective

Conduct comprehensive market research through multi-angle data collection and adversarial debate analysis. Produce feasibility assessment reports with theoretical evidence and verified technical implementation viability. Output formats: HTML, PPTX, PDF, DOCX.

## Deployment Mode: Agent Teams

This team runs in **Agent Teams mode** — each agent operates as an independent Claude Code instance with shared task lists and direct messaging.

Prerequisites:
- Set environment variable `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true`
- Launch the Commander agent as the entry point

### Communication Topology

- **Coordinator-mediated**: All task assignments and phase transitions go through the Commander.
- **Peer-to-peer in Phase 4 only**: Debate Analyst Pro and Debate Analyst Con exchange arguments directly during the multi-round debate phase. The Commander moderates and determines when the debate concludes.
- **Handoff protocol**: When an agent completes its deliverable, it marks the task as completed via `TaskUpdate` and sends a summary message to the Commander.

### Subagent Mode (Alternative)

This team also supports **subagent mode** where the Commander orchestrates all agents via the Task tool within a single session. In subagent mode:
- Debate rounds use file-based turn-taking (`round-N-pro.md` / `round-N-con.md`) instead of direct messaging.
- All other communication flows through Commander's task delegation.

### Task List Coordination

All agents share a single task list managed by the Commander. Agents must:
1. Check `TaskList` after completing each task to find available work.
2. Claim tasks by setting `owner` via `TaskUpdate` before starting work.
3. Mark tasks `completed` via `TaskUpdate` when done and notify the Commander via `SendMessage`.

## Workflow Phases

```
Phase 1: Intake & Planning          → Commander receives topic, selects research dimensions
Phase 2: Data Collection (parallel) → Investigator Alpha ∥ Investigator Beta
Phase 3: Independent Analysis        → Debate Analyst Pro ∥ Debate Analyst Con
Phase 4: Multi-Round Debate          → Pro ↔ Con (Commander moderates, minimum 1 full round)
Phase 5: Technical Assessment        → Tech Assessor
Phase 6: QC & Report Production      → Quality Inspector → Report Producer
```

## Universal Rules

### Communication Language

Communicate in the user's language. Detect and match the language the user uses. Technical terms may remain in English.

### Output Directory Convention

All research deliverables are placed under a project-specific output directory. The Commander defines this path at the start of each project. Agents must not write files outside the designated output directory.

### File Naming

Use kebab-case for all generated file and folder names. Spaces, underscores, and uppercase letters are prohibited in file names.

### Source Attribution

Every factual claim in the research must have a traceable source. Investigators provide a Source Registry that all downstream agents reference. Unsourced claims are flagged as violations during quality review.

### Evidence Standard

All data points, statistics, and factual claims must cite at least one verified source from the Source Registry. Sources rated below 3.0 credibility must not be used as primary evidence without corroboration from a source rated 3.0 or higher.

## Tech Stack

| Capability | Tools / Libraries | Skill Reference |
|---|---|---|
| HTML Reports | HTML/CSS/JS with responsive design | `skills/ui-ux-pro-max/` |
| PowerPoint (.pptx) | PptxGenJS (create), python-pptx + XML editing (template) | `skills/pptx/` |
| PDF Processing | pypdf, pdfplumber, reportlab, qpdf, Puppeteer | `skills/pdf/` |
| DOCX Processing | python-docx, pandoc | `skills/docx/` |
| Source Verification | WebSearch, WebFetch tools | `skills/source-verification/` |
| Web Research | WebSearch, WebFetch tools | `skills/web-research/` |
