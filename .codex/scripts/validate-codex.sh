#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path
import json
import sys
import tomllib

root = Path.cwd()
config_path = root / ".codex" / "config.toml"
if not config_path.exists():
    raise SystemExit("missing .codex/config.toml")

config = tomllib.loads(config_path.read_text())
agents = config.get("agents", {})
errors = []

for agent_id, entry in agents.items():
    if not isinstance(entry, dict):
        continue
    config_file = entry.get("config_file")
    if not config_file:
        continue
    agent_path = (config_path.parent / config_file).resolve()
    if not agent_path.exists():
        errors.append(f"{agent_id}: config_file does not exist: {config_file}")
        continue
    agent_config = tomllib.loads(agent_path.read_text())
    instructions = agent_config.get("developer_instructions", "").strip()
    if not instructions:
        errors.append(f"{agent_id}: developer_instructions is empty")

for required in [
    "AGENTS.md",
    ".codex/docs/claude-to-codex-mapping.md",
    ".codex/docs/claude-adaptation-audit.md",
    ".codex/skills/survey-corps/SKILL.md",
    ".agents/skills/survey-corps/SKILL.md",
]:
    if not (root / required).exists():
        errors.append(f"missing {required}")

hooks_path = root / ".codex" / "hooks.json"
if hooks_path.exists():
    json.loads(hooks_path.read_text())

if errors:
    print("Codex validation failed:")
    for error in errors:
        print(f"- {error}")
    sys.exit(1)

print("Codex validation passed")
PY
