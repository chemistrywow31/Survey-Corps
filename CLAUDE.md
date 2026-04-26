# Market Research Survey Corps

## Team Objective

Conduct comprehensive market research through multi-angle data collection and adversarial debate analysis. Produce feasibility assessment reports with theoretical evidence and verified technical implementation viability. Output formats: HTML, PPTX, PDF, DOCX.

## Team Roster (Survey Corps Theme)

| Agent | Role | Model |
|---|---|---|
| Levi | Coordinator — orchestrates the full 6-phase workflow | opus |
| Hange | Lead investigator (Phase 2) — data collection dimension set A | sonnet |
| Moblit | Second investigator (Phase 2) — data collection dimension set B | sonnet |
| Eren | Affirmative debate analyst (Phase 3-4) — pro-feasibility stance | opus |
| Armin | Skeptic debate analyst (Phase 3-4) — anti-feasibility stance | opus |
| Mikasa | Tech assessor (Phase 5) — technical feasibility evaluation | sonnet |
| Petra | Quality inspector (Phase 6) — QA of all deliverables | opus |
| Historia | Report producer (Phase 6) — HTML/PPTX/PDF/DOCX production | sonnet |
| Erwin | Process reviewer (post-project) — retrospective and improvement | sonnet |

Entry point: `/boss` — spawns Levi (coordinator) to run the full workflow.

## Deployment Mode: Agent Teams

This team runs in **Agent Teams mode** — each agent operates as an independent Claude Code instance with shared task lists and direct messaging.

Prerequisites:
- `.claude/settings.json` sets `env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = "1"` and `teammateMode = "in-process"` (already configured)
- Launch via `/boss` — the entry-point skill spawns Levi

### Known Limitations (Agent Teams)

- No `/resume` recovery for teammates — if a teammate's session ends, work resumes via worklog only
- Fixed lead per session — Levi is the coordinator and cannot be reassigned mid-session
- One team per session — cannot nest a sub-team inside Survey Corps
- No nested teams — Survey Corps cannot spawn another Agent Teams team
- No split-pane support in VS Code, Windows Terminal, or Ghostty — use a standard terminal for full visibility
- Teammates cannot share authentication — each teammate signs in independently if external services are required

### Communication Topology

- **Coordinator-mediated**: All task assignments and phase transitions go through Levi.
- **Peer-to-peer in Phase 4 only**: Eren and Armin exchange arguments directly during the multi-round debate phase. Levi moderates and determines when the debate concludes.
- **Handoff protocol**: When an agent completes its deliverable, it marks the task as completed via `TaskUpdate` and sends a summary message to Levi.

### Subagent Mode (Alternative)

This team also supports **subagent mode** where Levi orchestrates all agents via the Task tool within a single session. In subagent mode:
- Debate rounds use file-based turn-taking (`round-N-eren-*.md` / `round-N-armin-*.md`) instead of direct messaging.
- All other communication flows through Levi's task delegation.

### Task List Coordination

All agents share a single task list managed by Levi. Agents must:
1. Check `TaskList` after completing each task to find available work.
2. Claim tasks by setting `owner` via `TaskUpdate` before starting work.
3. Mark tasks `completed` via `TaskUpdate` when done and notify Levi via `SendMessage`.

## Workflow Phases

```
Phase 1: Intake & Planning          → Levi receives topic, selects research dimensions
Phase 2: Data Collection (parallel) → Hange ∥ Moblit
Phase 3: Independent Analysis        → Eren ∥ Armin
Phase 4: Multi-Round Debate          → Eren ↔ Armin (Levi moderates, minimum 1 full round)
Phase 5: Technical Assessment        → Mikasa
Phase 6: QC & Report Production      → Petra → Historia
Post:    Process Retrospective       → Erwin
```

## Universal Rules

### Communication Language

Communicate in the user's language. Detect and match the language the user uses. Technical terms may remain in English.

### Output Directory Convention

All research deliverables are placed under a project-specific output directory. Levi defines this path at the start of each project. Agents must not write files outside the designated output directory.

### File Naming

Use kebab-case for all generated file and folder names. Spaces, underscores, and uppercase letters are prohibited in file names.

### Source Attribution

Every factual claim in the research must have a traceable source. Hange and Moblit provide Source Registries that all downstream agents reference. Unsourced claims are flagged as violations during quality review.

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

## Worklog and Context Management

### Worklog Structure

Every market research project maintains a worklog under `.worklog/`:

```
.worklog/{yyyymm}/{project-name}/phase-{n}-{label}/
  ├── references.md    — Sources consulted
  ├── findings.md      — Key discoveries and analysis
  └── decisions.md     — Decisions with rationale and evidence
```

The three files form an evidence chain: **references → findings → decisions**. Every decision must trace back through findings to references.

### Levi's Dispatch Rules

Every task dispatch from Levi must include:
1. **Worklog path** — The directory where the agent writes outputs.
2. **Upstream reference paths** — Paths to relevant upstream phase worklogs.
3. **Task scope summary** — Concise description of what the task must accomplish.

Wrap variable data in XML tags to separate data from instructions.

### Agent Return Format

Every agent returns a structured summary upon task completion with one of these statuses:
- **DONE** — All steps completed successfully.
- **DONE_WITH_CONCERNS** — Completed with issues. List each concern.
- **BLOCKED** — Cannot proceed. State what was attempted and what is needed.
- **NEEDS_CONTEXT** — Missing information. List each missing item.

Full detail goes to the worklog; only the summary returns to Levi.

### Phase-End Archival

Levi verifies worklog completeness before each phase transition. Subsequent phases read from the worklog, not from prior context.
