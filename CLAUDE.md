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

Entry point: `/levi` — makes the CURRENT session adopt Levi (coordinator) as its playbook. Levi runs in the main session and is never spawned as a subagent: a spawned coordinator cannot dispatch agents and cannot converse with the user (production evidence: cloud-vm-iaas run stalled after Phase 2, `.worklog/202606`).

## Deployment Mode: Subagent (default)

This team runs in **subagent mode**: `/levi` makes the current session adopt `.claude/agents/levi.md`; Levi then dispatches all specialists via the Task tool within this single session.

- Debate rounds use file-based turn-taking (`round-N-eren-*.md` / `round-N-armin-*.md`). Levi moderates and determines when the debate concludes.
- All other communication flows through Levi's task dispatches and six-field returns (`rules/execution-contract.md` EC-1).
- Every accepted deliverable requires fresh-context verification per EC-3: the producer never accepts its own work, and Levi is never the sole acceptor of an intermediate artifact.

### Agent Teams Mode (secondary — do not use until preconditions are met)

Agent Teams mode (each agent an independent Claude Code instance with shared task lists and direct messaging) remains documented as a secondary option. Preconditions before switching to it:

- `.claude/settings.json` sets `env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = "1"` and `teammateMode = "in-process"` (already configured)
- Every agent .md gains a File Ownership section declaring the directories it owns (currently absent — mandatory for Agent Teams operation)
- Scoped worklog/output write permissions stay in `settings.json` — teammates cannot answer permission prompts

#### Known Limitations (Agent Teams)

- No `/resume` recovery for teammates — if a teammate's session ends, work resumes via worklog only
- Fixed lead per session — Levi is the coordinator and cannot be reassigned mid-session
- One team per session — cannot nest a sub-team inside Survey Corps
- No nested teams — Survey Corps cannot spawn another Agent Teams team
- No split-pane support in VS Code, Windows Terminal, or Ghostty — use a standard terminal for full visibility
- Teammates cannot share authentication — each teammate signs in independently if external services are required

#### Communication Topology (Agent Teams)

- **Coordinator-mediated**: All task assignments and phase transitions go through Levi.
- **Peer-to-peer in Phase 4 only**: Eren and Armin exchange arguments directly during the multi-round debate phase. Levi moderates and determines when the debate concludes.
- **Handoff protocol**: When an agent completes its deliverable, it marks the task as completed via `TaskUpdate` and sends a summary message to Levi.

#### Task List Coordination (Agent Teams)

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
4. **Acceptance criteria** — 1–5 mechanically checkable conditions; a fresh-context verifier checks exactly these per `rules/execution-contract.md` EC-3.
5. **Scope fence** — an explicit OUT list of files and directories the agent must not touch.

Wrap variable data in XML tags to separate data from instructions.

### Agent Return Format

Every task return follows the six-field schema in `rules/execution-contract.md` EC-1, in this order:

1. `STATUS:` DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT
2. `CONCLUSIONS:` outcomes and decisions, max 10 lines
3. `EVIDENCE:` file:line pointers or command outputs proving each conclusion — `STATUS: DONE` with empty EVIDENCE is invalid
4. `ARTIFACTS:` paths to every file produced or updated, including worklog files
5. `RISKS/UNKNOWNS:` issues Levi must know; "none" when none exist
6. `NEXT:` exactly one recommendation

Full detail goes to the worklog; only the summary returns to Levi.

### Verification and Phase-End Archival

Levi accepts a deliverable only after a fresh-context verifier (a separate dispatch that receives only the acceptance criteria and artifact paths) returns per-criterion PASS — the producer's own DONE claim never counts as acceptance (EC-3). Levi verifies worklog completeness before each phase transition. Subsequent phases read from the worklog, not from prior context.

## Precedence Order

When two instructions conflict, the higher source wins (adapted from `rules/execution-contract.md` EC-4). Resolve by citing this order:

1. Safety: `settings.json` deny rules and destructive-action guards
2. Charter: this CLAUDE.md and `rules/execution-contract.md`
3. EC-3 verification requirements
4. EC-1 reporting requirements
5. EC-2 escalation requirements
6. Other rules in `rules/`
7. Task-specific dispatch instructions
8. Style preferences (tone, formatting, length aesthetics)

## Runtime Authority

- **Claude Code sessions**: this `CLAUDE.md` + `.claude/` are the authoritative runtime surface.
- **Codex sessions**: `AGENTS.md` + `.codex/` + root `agents/` + `.agents/skills/` are the authoritative runtime surface.
- Neither tree is "legacy" — they are parallel platform implementations of the same team. Policy changes land in `.claude/` first, then mirror to `.codex/` per the AGENTS.md migration notes.

---

Generated by A-Team on 2026-04 (pre-hardening) · Retrofitted by A-Team (Phase 7 restructuring) on 2026-07-03
