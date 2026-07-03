# Claude To Codex Adaptation Audit

## Scope

This audit compares `CLAUDE.md` and `.claude/` against the active Codex runtime surface added to this project:

- `AGENTS.md`
- `.codex/config.toml`
- `.codex/hooks.json`
- `agents/**/*.toml`
- `.codex/agents/**/*.md`
- `.codex/rules/*.md`
- `.codex/skills/*`
- `.agents/skills/*`

## Migration Decisions

| Claude Source | Codex Action | Rationale |
| --- | --- | --- |
| `CLAUDE.md` | rewritten as `AGENTS.md` | Codex needs root project instructions without Claude Agent Teams assumptions. |
| `.claude/settings.json` | mapped to `.codex/config.toml`, `.codex/hooks.json`, and `.codex/rules/codex-runtime-config.md` | Preserves multi-agent and worklog-hook intent while avoiding Claude-specific config. |
| `.claude/agents/levi.md` | rewritten as `.codex/agents/levi.md` plus `agents/levi.toml` | Coordinator needed the largest Codex-native adaptation because Claude task tools do not exist in Codex. |
| Specialist agent files | copied and adapted under `.codex/agents/**` plus runtime TOML wrappers | Preserves domain behavior while replacing task/message tool language with Codex handoffs. |
| `.claude/rules/communication-protocol.md` | rewritten as `.codex/rules/communication-protocol.md` | Replaces Claude `SendMessage` and shared task list semantics with Codex-mediated handoffs and files. |
| `.claude/rules/context-management.md` | rewritten as `.codex/rules/context-management.md` | Preserves dispatch and completion contracts in a Codex-native shape. |
| `.claude/rules/*` | copied or adapted into `.codex/rules/` | Evidence, debate, report, worklog, and self-critique constraints remain portable. |
| `.claude/skills/boss` | replaced with `survey-corps` skill and `boss` alias | Codex uses skills and prompt files rather than Claude slash commands. |
| `.claude/skills/pdf`, `pptx`, `docx`, `ui-ux-pro-max` | mirrored to `.codex/skills` and `.agents/skills` | Runtime-discoverable skills retain scripts and reference material. |
| `.claude/skills/web-research`, `source-verification`, `debate-protocol` | mirrored and lightly adapted | Replaces Claude tool names with generic Codex web-search/browse language. |

## Deliberately Not Ported

- `.claude/settings.local.json`: local Claude permission override; no project-local Codex equivalent.
- Claude-only frontmatter keys such as `allowed-tools`, `disable-model-invocation`, and `argument-hint`: removed from Codex-native skills.
- Claude Agent Teams recovery limitations: replaced by Codex worklog recovery rules.

## Residual Compatibility Notes

- The imported document-processing skills were retagged to use `Codex` as the tracked-change/comment author where the upstream bundle previously used a legacy default.
- The legacy `.claude/` tree is intentionally untouched so future reverse conversion remains possible.
- Actual enforcement of approvals and sandbox policy depends on the host Codex runtime, not repository files.

## Levi Cross-Tree Reconciliation (2026-07-03, Phase 7 REC-3/REC-7)

`.codex/agents/levi.md` was resynced to `.claude/agents/levi.md` after the EC-3 fresh-context verification gate was added to the Claude Levi. Ported into Codex vocabulary: the verification gate (`spawn_agent`/local-pass instead of the Claude Task tool), the full Field-Classification cascade detail, a `## Context Tier` counterpart, and a `## Compaction Strategy` counterpart. The remaining `.claude` Levi `##` sections have no Codex counterpart by intent:

- **`## Communication Patterns`** — the Claude version is Agent-Teams message tables (`SendMessage`/broadcast). Codex coordination is described in `### Codex Delegation` and `## Tools And Runtime` (`spawn_agent`/`send_input`/`wait_agent`); a message-routing table would reintroduce Claude-only semantics.
- **`## Uncertainty Protocol`** — its content lives in `## Completion Format`, which carries the `NEEDS_CONTEXT` and `BLOCKED` return templates and the two-attempt interpretation rule.
- **`## Examples`** — the three Claude examples are omitted from the Codex playbook for brevity; the same behavior is fixed by `### Codex Delegation`, the phase gates, and the `## Completion Format` templates.

## Validation Notes

- `AGENTS.md` is the active project doc.
- `.codex/config.toml` parses as TOML and resolves runtime agent wrappers from `.codex/`.
- Skills exist in both `.codex/skills/` and `.agents/skills/`.
- `.codex/scripts/validate-codex.sh` provides a fast structural check.
