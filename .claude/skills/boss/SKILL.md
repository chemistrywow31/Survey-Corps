---
name: Boss
description: Entry point that spawns Levi (the Survey Corps coordinator) to run the market research workflow
disable-model-invocation: true
allowed-tools: ["Agent"]
argument-hint: "[research topic, output format hint, deadline]"
---

# Boss

## Description

Launch Levi, captain and coordinator of the Market Research Survey Corps, to run the complete market research workflow. Use this skill as the standard entry point for all Survey Corps research requests.

## Trigger

Use when the user wants to conduct market research, feasibility analysis, or competitive intelligence gathering with multi-angle data collection and adversarial debate analysis.

## Execution

When invoked, spawn the Levi agent via the Agent tool:

1. Parse any arguments the user provided (research topic, constraints, output format preferences)
2. Spawn the `levi` agent via the Agent tool with `subagent_type` set to `levi`
3. Pass the user's request and any arguments as the agent's prompt
4. Levi runs the full 6-phase workflow: Intake → Data Collection → Independent Analysis → Debate → Technical Assessment → QC & Report Production

### Spawn Instructions

Use the Agent tool with these parameters:

- `subagent_type`: `levi`
- `prompt`: Include the user's original request and any arguments. If the user provided no details, instruct Levi to begin with Phase 1 Intake.

## Examples

### Normal Case

User: `/boss AI-powered customer service chatbot market feasibility, output PPTX and HTML, deadline next Friday`

Action: Spawn Levi with prompt:
```
Conduct market research for: AI-powered customer service chatbot market feasibility.
Output formats: PPTX and HTML. Deadline: next Friday.

Begin with Phase 1 Intake. Confirm scope, classify field velocity (likely rapid_change for AI),
and present Requirements Summary for user approval before Phase 2.
```

### Edge Case — Partial Requirements

User: `/boss electric vehicles`

Action: Spawn Levi with prompt:
```
Conduct market research for: electric vehicles. The topic is broad — begin with Phase 1 Intake
and clarify scope, target market (consumer/commercial/fleet), specific questions, and output format
with the user before proceeding.
```

### Rejection Case — No Research Topic

User: `/boss`

Action: Spawn Levi with prompt:
```
The user wants to conduct market research but has not specified a topic. Begin with Phase 1 Intake
— ask the user for the research topic, target market, specific questions to answer, and desired
output formats (HTML/PPTX/PDF/DOCX) before proceeding.
```
