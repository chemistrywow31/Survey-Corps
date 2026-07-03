# Claude To Codex Mapping

This document records how the legacy Survey Corps `.claude/` assets map to the active Codex runtime layout.

## Canonical Rule

- Codex-native assets are the active runtime.
- `.claude/` and `CLAUDE.md` remain legacy/source material for compatibility and future round-trip conversion.
- Do not edit `.claude/` during Codex work unless the user explicitly requests Claude compatibility updates.

## Path Mapping

| Legacy Claude asset | Codex asset | Status | Notes |
| --- | --- | --- | --- |
| `CLAUDE.md` | `AGENTS.md` | adapted | Root project instructions rewritten for Codex runtime and local worklog handoffs. |
| `.claude/settings.json` | `.codex/config.toml`, `.codex/hooks.json`, `.codex/rules/codex-runtime-config.md` | adapted | Agent Teams and hooks mapped to Codex multi-agent config and optional hook intent. |
| `.claude/settings.local.json` | none | not ported | User-local Claude permission override has no project-local Codex equivalent. |
| `.claude/agents/**/*.md` | `.codex/agents/**/*.md` + `agents/**/*.toml` | adapted | Markdown playbooks kept under `.codex/agents`; runtime wrappers registered in `.codex/config.toml`. |
| `.claude/rules/*.md` | `.codex/rules/*.md` | adapted | Claude-only task/message semantics replaced with Codex handoffs and worklog state. |
| `.claude/skills/*` | `.codex/skills/*` + `.agents/skills/*` | adapted | Authored mirror plus runtime-discoverable skill copy. |
| `.claude/skills/boss` | `.codex/skills/survey-corps`, `.agents/skills/survey-corps`, alias `boss` | adapted | Legacy `/boss` becomes Codex skill entry. |

## Agent Mapping

| Role | Runtime config | Playbook |
| --- | --- | --- |
| Levi | `agents/levi.toml` | `.codex/agents/levi.md` |
| Hange | `agents/research/hange.toml` | `.codex/agents/research/hange.md` |
| Moblit | `agents/research/moblit.toml` | `.codex/agents/research/moblit.md` |
| Eren | `agents/analysis/eren.toml` | `.codex/agents/analysis/eren.md` |
| Armin | `agents/analysis/armin.toml` | `.codex/agents/analysis/armin.md` |
| Mikasa | `agents/analysis/mikasa.toml` | `.codex/agents/analysis/mikasa.md` |
| Petra | `agents/output/petra.toml` | `.codex/agents/output/petra.md` |
| Historia | `agents/output/historia.toml` | `.codex/agents/output/historia.md` |
| Erwin | `agents/review/erwin.toml` | `.codex/agents/review/erwin.md` |

## Runtime Notes

- `.codex/config.toml` is the project-local source of truth for multi-agent enablement.
- `config_file` paths are resolved from `.codex/config.toml`, so project-root runtime agent files are referenced as `../agents/...`.
- `.codex/agents/**/*.md` files are authored playbooks and are not registered directly as agent config files.
- If Codex named agents are unavailable, use generic workers with the relevant `.codex/agents/**/*.md` playbook included in the prompt.
- If Codex delegation is unavailable or not authorized, Levi executes locally with explicit role sections and worklog artifacts.

## Lossy And Deliberate Adaptations

| Claude concept | Codex adaptation |
| --- | --- |
| Claude Agent Teams `TaskCreate`, `TaskUpdate`, `TaskList`, `TaskGet`, `SendMessage` | Codex `spawn_agent`, `send_input`, `wait_agent`, local checklists, structured summaries, and worklog artifacts. |
| Slash command `/boss` | Runtime skill `survey-corps` plus alias skill `boss` and prompt files. |
| Claude permission allow/ask/deny settings | Host-controlled Codex sandbox and approval policy; intent documented but not enforced by copied Claude settings. |
| Claude model names `opus` and `sonnet` | Codex model and reasoning effort in `agents/**/*.toml`. |
| Claude local setting allowing `Agent` | Not ported; Codex delegation remains governed by active runtime and user authorization. |

## Validation

Run:

```bash
.codex/scripts/validate-codex.sh
```

The validator checks that `.codex/config.toml` parses, agent `config_file` paths resolve, runtime wrappers contain `developer_instructions`, hooks JSON parses, and canonical entry skills exist in both skill mirrors.
