# Survey Corps — Market Research Agent Team
![surveycorps.png](surveycorps.png)<br>
A multi-agent market research team built on Claude Code Agent Teams. The team conducts comprehensive market feasibility assessments through structured data collection, adversarial debate analysis, and technical evaluation, producing polished reports in multiple formats.

## Quick Start

```bash
# Set the required environment variable
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true

# Launch Claude Code — the Commander agent is the entry point
claude
```

Provide a research topic and the Commander will guide you through requirements intake, then orchestrate the full research pipeline automatically.

## Team Members

The team consists of 8 specialized agents organized into 4 functional groups.

### Command

| Agent | Model | Description |
|---|---|---|
| **Commander** | Opus | Orchestrates the entire workflow. Receives user requirements, plans research dimensions, dispatches tasks, moderates debates, enforces phase gates, and routes revisions. Does not perform any research or production work. |

### Research

| Agent | Model | Description |
|---|---|---|
| **Investigator Alpha** | Sonnet | Primary data collection agent. Conducts web research for assigned dimensions, verifies sources with credibility scoring, and produces `evidence-dossier-alpha.md`. |
| **Investigator Beta** | Sonnet | Secondary data collection agent. Same role as Alpha but for a different set of dimensions. Produces `evidence-dossier-beta.md`. |

### Analysis

| Agent | Model | Description |
|---|---|---|
| **Debate Analyst Pro** | Opus | Argues the **affirmative** case for market feasibility. Builds evidence-backed arguments supporting viability and engages in structured multi-round debate. |
| **Debate Analyst Con** | Opus | Argues the **opposing** case against market feasibility. Identifies risks, challenges, and reasons for caution through evidence-backed counterarguments. |
| **Tech Assessor** | Sonnet | Evaluates technical feasibility after the debate concludes. Assesses technology maturity, implementation complexity, scalability, and produces a risk register with mitigations. |

### Output

| Agent | Model | Description |
|---|---|---|
| **Quality Inspector** | Opus | Validates all deliverables against quality standards. Checks source citations, debate compliance, report completeness, and produces QA reports with severity-rated issues. |
| **Report Producer** | Sonnet | Compiles approved deliverables into the final report. Generates output in HTML (master), PPTX, PDF, and DOCX formats using specialized skills. |

## Workflow Phases

```
Phase 1  Intake & Planning           Commander receives topic, clarifies scope, selects dimensions
           │
Phase 2  Data Collection (parallel)  Investigator Alpha ∥ Investigator Beta
           │
Phase 3  Independent Analysis        Debate Analyst Pro ∥ Debate Analyst Con
           │
Phase 4  Multi-Round Debate          Pro ↔ Con (Commander moderates, min 1 full round)
           │
Phase 5  Technical Assessment        Tech Assessor evaluates implementation viability
           │
Phase 6  QC & Report Production      Quality Inspector → Report Producer
```

Each phase has a strict gate — the Commander verifies all tasks in the current phase are completed before advancing to the next.

## Communication Topology

- **Coordinator-mediated**: All task assignments and phase transitions go through the Commander.
- **Peer-to-peer (Phase 4 only)**: Debate Analyst Pro and Debate Analyst Con exchange arguments directly during the debate. The Commander moderates and decides when the debate concludes.
- **Handoff protocol**: When an agent finishes, it marks the task completed via `TaskUpdate` and sends a summary to the Commander via `SendMessage`.

## Debate Structure

Each debate round follows a fixed sequence:

1. **Pro Opening** — Affirmative case with evidence
2. **Con Rebuttal** — Counterarguments addressing Pro's points
3. **Pro Counter-Rebuttal** — Response reinforcing key points
4. **Con Closing** — Final counterarguments and summary

All submissions must include: Stance Declaration, Core Arguments with source citations, Concessions, Risk Assessment, and Key Takeaway.

## Evidence Standards

- Every factual claim must cite a Source Registry entry (`[SRC-xxx]`).
- Sources are scored 1.0–5.0 on credibility (Author Authority, Publication Reputation, Recency, Corroboration).
- Sources below 3.0 cannot be used as primary evidence without corroboration from a 3.0+ source.
- Sources below 2.0 are rejected entirely.

## Output Formats

| Format | Tool | Key Requirements |
|---|---|---|
| HTML | HTML/CSS/JS | Responsive, WCAG AA contrast, print-friendly, interactive TOC |
| PPTX | PptxGenJS / python-pptx | Max 6 bullets per slide, speaker notes on every content slide |
| PDF | Puppeteer / reportlab | Preserved layout, embedded fonts, TOC with page numbers |
| DOCX | python-docx / pandoc | Heading hierarchy, auto TOC, page numbers |

## Report Sections

Every final report contains these 7 sections:

1. **Executive Summary** — 200-400 word overview with key findings and recommendation
2. **Research Methodology** — Dimensions, approach, source statistics
3. **Market Analysis** — Findings per dimension with inline citations
4. **Debate Analysis** — Pro vs. Con synthesis, agreements, disagreements
5. **Technical Feasibility** — Maturity, complexity, risk register, recommendation
6. **Conclusions & Recommendations** — Actionable synthesis
7. **Appendices** — Full Source Registry, debate transcripts, raw data

## Project Structure

```
.claude/
├── agents/
│   ├── commander.md                    # Commander agent definition
│   ├── research/
│   │   ├── investigator-alpha.md       # Investigator Alpha
│   │   └── investigator-beta.md        # Investigator Beta
│   ├── analysis/
│   │   ├── debate-analyst-pro.md       # Debate Analyst Pro
│   │   ├── debate-analyst-con.md       # Debate Analyst Con
│   │   └── tech-assessor.md            # Tech Assessor
│   └── output/
│       ├── quality-inspector.md        # Quality Inspector
│       └── report-producer.md          # Report Producer
├── rules/
│   ├── communication-protocol.md       # Inter-agent messaging rules
│   ├── debate-standards.md             # Debate format and moderation rules
│   ├── evidence-standard.md            # Source credibility and citation rules
│   └── report-quality.md              # Report structure and QA checklist
└── skills/
    ├── ui-ux-pro-max/                  # HTML report design
    ├── pptx/                           # PowerPoint generation
    ├── pdf/                            # PDF processing
    ├── docx/                           # Word document generation
    ├── web-research/                   # Structured research methodology
    ├── source-verification/            # Source credibility assessment
    └── debate-protocol/                # Debate submission templates
```

## Deployment Modes

### Agent Teams (Default)

Each agent runs as an independent Claude Code instance with shared task lists and direct messaging. Requires `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true`.

### Subagent Mode (Alternative)

The Commander orchestrates all agents via the Task tool within a single session. Debate rounds use file-based turn-taking (`round-N-pro.md` / `round-N-con.md`) instead of direct messaging.
