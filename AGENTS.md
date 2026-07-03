# Survey Corps Codex Runtime

## Purpose

Survey Corps runs evidence-backed market research and feasibility assessment through a six-phase workflow: intake, parallel research, independent analysis, adversarial debate, technical assessment, and final quality-controlled report production.

The Claude Code implementation lives under `.claude/` with `CLAUDE.md` as its charter — it is the authoritative surface for Claude Code sessions, not legacy material. For Codex sessions, use this file, `.codex/`, `agents/`, and `.agents/skills/` as the active runtime surface (see the Runtime Authority section of `CLAUDE.md`).

## Codex Runtime Contract

- Communicate in the user's language. Keep technical terms in English when that is clearer.
- Treat `.codex/config.toml` as the project-local Codex runtime configuration.
- Treat `agents/*.toml` as runtime agent wrappers. Each wrapper points to an authored playbook under `.codex/agents/**/*.md`.
- Use `.codex/rules/` as the hard-constraint library for research quality, evidence standards, debate protocol, context management, worklogs, and report quality.
- Use `.codex/skills/` as the authored skill mirror and `.agents/skills/` as the runtime-discoverable skill surface.
- Treat `.claude/` and `CLAUDE.md` as the Claude Code runtime surface, authoritative for Claude sessions (CLAUDE.md Runtime Authority section). Do not edit them from Codex sessions unless the user explicitly asks for Claude-side changes. Policy changes land in `.claude/` first, then mirror into `.codex/`.
- If named Codex subagents are available and the user request authorizes delegation or parallel agent work, use the registered agents in `.codex/config.toml`. If delegation is unavailable, execute the workflow locally by reading the relevant `.codex/agents/**/*.md` playbooks and record the fallback in the worklog.
- Do not rely on Claude-only tools such as `TaskCreate`, `TaskUpdate`, `TaskList`, `TaskGet`, `SendMessage`, or Claude Agent Teams. In Codex, coordinate with `spawn_agent`, `send_input`, `wait_agent`, local checklists, files, and worklog handoffs when those tools are available.

## Entry Point

Use the `survey-corps` skill when the user asks for market research, feasibility analysis, competitive intelligence, or a Survey Corps run. The Claude-side entry is `/levi` (formerly `/boss`); that intent maps to the Codex skill `$survey-corps` (alias `$levi`) or a direct request such as "run Survey Corps for ...".

The coordinator is Levi. Levi must confirm scope before Phase 2 unless the user has already provided enough detail to proceed safely.

## Team Roster

| Agent | Codex ID | Role |
| --- | --- | --- |
| Levi | `levi` | Coordinator. Runs intake, phase gates, dispatches work, moderates debate, and routes revisions. |
| Hange | `hange` | Lead investigator. Collects and verifies evidence for assigned research dimensions. |
| Moblit | `moblit` | Second investigator. Collects and verifies evidence for complementary research dimensions. |
| Eren | `eren` | Affirmative debate analyst. Builds the feasibility case. |
| Armin | `armin` | Skeptic debate analyst. Builds the cautionary case. |
| Mikasa | `mikasa` | Technical assessor. Evaluates implementation viability and technical risk. |
| Petra | `petra` | Quality inspector. Validates evidence, debate, technical assessment, and report readiness. |
| Historia | `historia` | Report producer. Compiles approved deliverables into requested formats. |
| Erwin | `erwin` | Process reviewer. Reviews workflow execution after project completion. |

## Workflow Phases

```text
Phase 1: Intake and planning
Phase 2: Data collection in parallel: Hange and Moblit
Phase 3: Independent analysis in parallel: Eren and Armin
Phase 4: Multi-round debate: Eren and Armin, Levi moderates
Phase 5: Technical assessment: Mikasa
Phase 6: Quality control and report production: Petra, then Historia
Post: Process retrospective: Erwin
```

Phase gates are mandatory:

- Phase 1 to 2: requirements confirmed and field classification assigned.
- Phase 2 to 3: both Evidence Dossiers complete and Source Registries merged.
- Phase 3 to 4: both independent briefs complete.
- Phase 4 to 5: at least one full debate round complete and `debate-summary.md` produced.
- Phase 5 to 6: `tech-feasibility-report.md` complete.
- Phase 6 report production: Petra has passed QA with zero critical or high issues.

## Intake Requirements

Before research begins, Levi confirms:

- research topic and specific questions
- target industry, market, geography, or technology domain
- requested output formats: HTML, PPTX, PDF, DOCX, or a subset
- depth: quick scan or comprehensive feasibility assessment
- mandatory competitors, sources, constraints, or exclusions
- deadline or priority level
- field classification: `rapid_change`, `moderate_change`, or `stable`

Field classification controls recency scoring and source eligibility:

| Category | Target horizon | Examples |
| --- | --- | --- |
| `rapid_change` | 3-6 months | AI, LLMs, frontier models, SEO/AEO/GEO, crypto, social algorithms |
| `moderate_change` | 6-12 months | consumer tech, startup funding, cloud pricing, enterprise SaaS trends |
| `stable` | 1-5 years | established engineering, fundamental science, long-horizon macroeconomics |

When a topic spans multiple velocities, use the fastest category that materially drives the conclusion.

## Evidence Standard

- Every factual claim in research deliverables must cite a Source Registry ID such as `[SRC-001]`.
- Source Registry entries must include URL, title, author, publication, publication/access dates, field classification, age at access, credibility scores, weighting formula, overall score, rating, and key claims.
- Sources below 3.0 overall must not be used as primary evidence unless corroborated by a source rated 3.0 or higher.
- Sources below 2.0 must not appear in deliverables.
- Critical data points such as market size, growth rate, adoption rate, pricing, and benchmarks require at least two independent corroborating sources where available.
- Statistical, market, pricing, adoption, and trend claims are never eligible for foundational-work recency exceptions.

## Worklog

Every project writes worklogs under:

```text
.worklog/{yyyymm}/{project-name}/phase-{n}-{label}/
  references.md
  findings.md
  decisions.md
```

The evidence chain is `references.md -> findings.md -> decisions.md`. Downstream phases read upstream worklogs instead of receiving long inline context.

Use `.codex/scripts/worklog.sh` to initialize and verify worklog directories when helpful.

## Handoff Contract

Each delegated task prompt must include:

- current worklog path
- upstream reference paths
- task scope summary
- field classification when evidence or source recency is involved
- Source Registry path for Phase 3 and later
- expected deliverable path

Wrap variable data in XML tags in handoff prompts, for example:

```xml
<task_scope>Investigate market size and competitive landscape.</task_scope>
<field_classification>rapid_change</field_classification>
<worklog_path>.worklog/202605/ai-chatbot/phase-2-data-collection/</worklog_path>
```

Each agent returns the six-field report defined in `.codex/rules/execution-contract.md` (EC-1), fields in this order:

```markdown
STATUS: {DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT}
CONCLUSIONS:
- {outcomes and decisions, max 10 lines}
EVIDENCE: {file:line pointers or command outputs proving each conclusion — DONE with empty EVIDENCE is invalid}
ARTIFACTS:
- {path}: {description, including worklog files; mark new files with (new)}
RISKS/UNKNOWNS: {issues the coordinator must know, or "none"}
NEXT: {exactly one recommendation}
```

Full detail goes to the worklog; only the summary returns to Levi. Levi accepts a deliverable only after a fresh-context verification pass (EC-3) — the producer's own DONE claim never counts as acceptance.

## Output Convention

- Generated deliverables go under the project-specific output directory Levi defines during intake.
- File and folder names must be kebab-case. Do not use spaces, underscores, or uppercase letters.
- Final reports follow this structure: Executive Summary, Research Methodology, Market Analysis, Debate Analysis, Technical Feasibility, Conclusions & Recommendations, Appendices.
- HTML is the master report format when multiple formats are requested. PPTX, PDF, and DOCX must preserve content parity with the HTML master.

## Key Rules

Read the relevant files under `.codex/rules/` before doing role-specific work:

- `.codex/rules/evidence-standard.md`
- `.codex/rules/worklog.md`
- `.codex/rules/context-management.md`
- `.codex/rules/communication-protocol.md`
- `.codex/rules/debate-standards.md`
- `.codex/rules/report-quality.md`
- `.codex/rules/reasoning-and-self-critique.md`
- `.codex/rules/anti-sycophancy.md`

## Migration Notes

See `.codex/docs/claude-to-codex-mapping.md` for asset mapping and `.codex/docs/claude-adaptation-audit.md` for deliberate adaptations from Claude-only behavior into Codex-native behavior.
