---
name: Codex Runtime Config
description: Project-local Codex runtime layout and Claude-to-Codex settings adaptation
---

# Codex Runtime Config

## Runtime Layout

- `AGENTS.md`: active project instructions loaded by Codex.
- `.codex/config.toml`: project-local runtime settings and agent registry.
- `agents/**/*.toml`: runtime agent wrappers referenced by `.codex/config.toml`.
- `.codex/agents/**/*.md`: authored role playbooks.
- `.codex/rules/*.md`: reusable project rules.
- `.codex/skills/*/SKILL.md`: authored project skills.
- `.agents/skills/*/SKILL.md`: runtime-discoverable skill mirror.
- `.codex/hooks.json`: optional local hook intent migrated from Claude settings.

## Claude Settings Mapping

| Claude setting | Codex adaptation |
| --- | --- |
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` | `[features].multi_agent = true` |
| `teammateMode = "in-process"` | `[agents] max_depth = 1` and registered project agents |
| Permission allow/ask/deny list | documented as runtime policy; Codex approval and sandbox policy are host-controlled |
| `SessionStart` worklog hook | `.codex/hooks.json` `session_start` |
| `UserPromptSubmit` session ledger hook | `.codex/hooks.json` `user_prompt_submit` |
| `PreCompact` checkpoint hook | `.codex/hooks.json` `pre_compact` |
| `Stop` worklog check | `.codex/hooks.json` `stop` |

## Rules

- Do not require `.claude/settings.json` for Codex execution.
- Do not place runtime agent TOML under `.codex/agents/`; use project-root `agents/`.
- Every `config_file` in `.codex/config.toml` is resolved relative to `.codex/`, so project-root agent files use `../agents/...`.
- Do not register Markdown playbooks as runtime agent configs.
