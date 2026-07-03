---
name: survey-corps
description: Start the Survey Corps Codex-native market research and feasibility assessment workflow
---

# Survey Corps

## Description

Use this skill when the user asks for market research, feasibility analysis, competitive intelligence, market entry assessment, product or technology viability assessment, or a Survey Corps run.

This is the Codex-native replacement for the legacy Claude `/boss` entry point.

## Core Knowledge

- `AGENTS.md` is the active Codex project contract.
- `.codex/config.toml` registers Survey Corps roles for Codex multi-agent runtimes.
- `agents/**/*.toml` are runtime wrappers.
- `.codex/agents/**/*.md` are the authoritative role playbooks.
- `.codex/rules/*.md` define evidence, debate, worklog, and report quality requirements.
- `.claude/` remains legacy/source material and must not be edited unless explicitly requested.

## Trigger Rules

Use this skill for:

- "run Survey Corps"
- `/boss` or `$boss`
- market research
- feasibility analysis
- competitive intelligence
- technical or market viability assessment
- final reports in HTML, PPTX, PDF, or DOCX

Do not use this skill for unrelated coding tasks in this repository.

## Execution

1. Read `AGENTS.md`.
2. Read `.codex/agents/levi.md`.
3. Start Phase 1 Intake unless the user's prompt already provides topic, market/domain, research questions, output formats, depth, and constraints.
4. Classify the field as `rapid_change`, `moderate_change`, or `stable`; record a one-sentence rationale.
5. Produce a Requirements Summary and obtain user approval before Phase 2 unless the user explicitly asks to proceed autonomously and the scope is unambiguous.
6. Use Codex subagents when the active runtime and user request permit delegation. Otherwise execute locally by following each role playbook and writing artifacts to the worklog.
7. Keep all generated deliverables under Levi's designated output directory.

## With Arguments

Treat arguments as the initial research brief. Extract:

- topic
- target market or domain
- specific questions
- requested formats
- deadline or priority
- mandatory sources, competitors, constraints, or exclusions

## No Arguments

Ask one focused intake question requesting the research topic, target market/domain, output format, and desired depth.

## Completion

The workflow is complete only when:

- Phase 6 QA passes, or unresolved concerns are explicitly accepted by the user.
- Requested formats are produced.
- Final response lists artifact paths and remaining risks.
