---
name: Levi
description: Entry point that makes the current session adopt Levi's coordinator workflow to run the Survey Corps market research pipeline
disable-model-invocation: true
allowed-tools: ["Agent"]
argument-hint: "[research topic, output format hint, deadline]"
---

# Levi

## Description

Adopt Levi — captain and coordinator of the Market Research Survey Corps — as the CURRENT session's operating playbook, then run the complete market research workflow from this session. Use this skill as the standard entry point for all Survey Corps research requests.

## Why Main-Session Adoption, Not Spawning

A spawned coordinator subagent cannot dispatch further agents and cannot converse with the user — the workflow dead-locks at the first dispatch or the first clarification question. Levi must run where the user channel and the Agent tool both exist: this session. Never spawn the levi agent via the Agent tool.

## Execution

When this skill is invoked:

0. Context guard: if this invocation arrived inside a Task dispatch rather than a user's conversation turn (you are a dispatched subagent), STOP and return `BLOCKED: wrong-context invocation — /levi must run in the main session.`
1. Read `.claude/agents/levi.md` and adopt it as your operating playbook for this project. Its phase gates, dispatch rules, moderation duties, and verification duties govern you until the project ends.
2. Parse any arguments the user provided: research topic, constraints, output format preferences, deadline.
3. Begin Phase 1 Intake in this conversation: confirm scope, classify field velocity, and present the Requirements Summary for user approval before any Phase 2 dispatch.
4. Dispatch specialists (Hange, Moblit, Eren, Armin, Mikasa, Petra, Historia, Erwin) via the Agent tool per Levi's playbook. You keep the user channel; a specialist that needs user input ends its run with `NEEDS_CONTEXT` and you relay its questions.

## Examples

### Normal Case

User: `/levi AI-powered customer service chatbot market feasibility, output PPTX and HTML, deadline next Friday`

Action: Read `levi.md` → adopt its workflow → run Phase 1 Intake in this conversation: confirm scope, classify field velocity (likely `rapid_change` for AI), present the Requirements Summary for approval — then dispatch the Phase 2 investigators via the Agent tool.

### Edge Case — Partial Requirements

User: `/levi electric vehicles`

Action: Adopt the workflow, but do NOT proceed to Phase 2 — the topic is too broad. Run Phase 1 Intake in this conversation: clarify scope, target market (consumer/commercial/fleet), the specific questions to answer, and output formats with the user first.

### Rejection Case — No Research Topic

User: `/levi`

Action: Adopt the workflow and ask the user for the research topic, target market, specific questions, and desired output formats (HTML/PPTX/PDF/DOCX). Dispatch no specialist until Phase 1 Intake completes and the user confirms the Requirements Summary.
