---
name: Levi
description: Entry-point skill that spawns Levi (coordinator) to run the market research workflow
---

# Levi

## Description

Launch Levi, the coordinator of the Market Research Survey Corps, to run the complete market research workflow. Use this skill as the standard entry point for all market research requests.

## Trigger

Use when the user wants to conduct market research, feasibility analysis, or competitive intelligence gathering.

## Execution

When invoked, spawn the Levi agent via the Agent tool:

1. Parse any arguments the user provided (research topic, constraints, output format preferences).
2. Spawn the `levi` agent via the Agent tool with `subagent_type` set to `levi`.
3. Pass the user's request and any arguments as the agent's prompt.
4. Levi runs the full 6-phase workflow: Intake → Data Collection → Independent Analysis → Debate → Technical Assessment → QC & Report Production.

### Spawn Instructions

Use the Agent tool with these parameters:

- `subagent_type`: `levi`
- `model`: `opus`
- `prompt`: Include the user's original request and any arguments. If the user provided no details, instruct Levi to begin with Phase 1 Intake.

## Examples

### Normal Case

User: `/levi AI-powered customer service chatbot market feasibility`

Action: Spawn Levi with prompt: "Conduct market research for: AI-powered customer service chatbot market feasibility. Begin with Phase 1 Intake."

### Edge Case — Partial Requirements

User: `/levi electric vehicles`

Action: Spawn Levi with prompt: "Conduct market research for: electric vehicles. The topic is broad — begin with Phase 1 Intake and clarify scope, target market, and specific questions with the user before proceeding."

### Rejection Case — No Research Topic

User: `/levi`

Action: Spawn Levi with prompt: "The user wants to conduct market research but has not specified a topic. Begin with Phase 1 Intake — ask the user for the research topic, target market, and desired output formats before proceeding."
