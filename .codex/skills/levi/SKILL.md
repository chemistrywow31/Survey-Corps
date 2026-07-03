---
name: levi
description: Entry alias for the Survey Corps Codex workflow. Use `survey-corps` for the canonical skill name.
---

# Levi

`levi` is the entry alias matching the Claude-side `/levi` command (formerly `/boss`). In Codex, follow `.codex/skills/survey-corps/SKILL.md`.

## Trigger

Use when the user says `/levi`, `$levi`, "levi", legacy `/boss` or `$boss`, or asks to launch the Survey Corps workflow.

## Execution

1. Read `AGENTS.md`.
2. Read `.codex/skills/survey-corps/SKILL.md`.
3. Start Levi's Phase 1 intake unless the user's prompt already includes enough details to produce a Requirements Summary.
4. Use Codex delegation only when the active runtime and user request allow it. Otherwise execute locally with role playbooks.
