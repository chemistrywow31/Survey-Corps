#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  .codex/scripts/worklog.sh init "project name"
  .codex/scripts/worklog.sh phase "project name" 2 data-collection
  .codex/scripts/worklog.sh prompt "project name" "prompt text"
  .codex/scripts/worklog.sh checkpoint "project name" "reason"
  .codex/scripts/worklog.sh verify "project name" 2 data-collection
USAGE
}

slugify() {
  local slug
  slug="$(
    printf '%s' "$1" |
      tr '[:upper:]' '[:lower:]' |
      sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//; s/-+/-/g'
  )"

  if [[ -z "$slug" ]]; then
    slug="project-$(printf '%s' "$1" | cksum | awk '{print $1}')"
  fi

  printf '%s' "$slug"
}

month_key() {
  date +%Y%m
}

project_root() {
  local project_slug="$1"
  printf '.worklog/%s/%s' "$(month_key)" "$project_slug"
}

ensure_phase() {
  local project_slug="$1"
  local phase_num="$2"
  local phase_label
  phase_label="$(slugify "$3")"
  local dir
  dir="$(project_root "$project_slug")/phase-${phase_num}-${phase_label}"

  mkdir -p "$dir"

  for file in references.md findings.md decisions.md; do
    if [[ ! -f "$dir/$file" ]]; then
      printf '# %s\n\n' "${file%.md}" > "$dir/$file"
    fi
  done

  printf '%s\n' "$dir"
}

require_phase_files() {
  local project_slug="$1"
  local phase_num="$2"
  local phase_label
  phase_label="$(slugify "$3")"
  local dir
  dir="$(project_root "$project_slug")/phase-${phase_num}-${phase_label}"

  local missing=0
  for file in references.md findings.md decisions.md; do
    if [[ ! -s "$dir/$file" ]]; then
      printf 'MISSING: %s/%s\n' "$dir" "$file" >&2
      missing=1
    fi
  done

  return "$missing"
}

cmd="${1:-}"
shift || true

case "$cmd" in
  init)
    [[ $# -ge 1 ]] || { usage; exit 2; }
    project_slug="$(slugify "$1")"
    root="$(project_root "$project_slug")"
    mkdir -p "$root"
    [[ -f "$root/session-ledger.md" ]] || printf '# Session Ledger\n\n' > "$root/session-ledger.md"
    ensure_phase "$project_slug" 1 intake >/dev/null
    printf '%s\n' "$root"
    ;;
  phase)
    [[ $# -ge 3 ]] || { usage; exit 2; }
    project_slug="$(slugify "$1")"
    ensure_phase "$project_slug" "$2" "$3"
    ;;
  prompt)
    [[ $# -ge 2 ]] || { usage; exit 2; }
    project_slug="$(slugify "$1")"
    shift
    root="$(project_root "$project_slug")"
    mkdir -p "$root"
    printf '\n## %s\n\n%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$*" >> "$root/session-ledger.md"
    printf '%s/session-ledger.md\n' "$root"
    ;;
  checkpoint)
    [[ $# -ge 2 ]] || { usage; exit 2; }
    project_slug="$(slugify "$1")"
    shift
    root="$(project_root "$project_slug")"
    mkdir -p "$root"
    reason="$*"
    printf '{"ts":"%s","reason":"%s"}\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$(printf '%s' "$reason" | sed 's/"/\\"/g')" > "$root/compact-checkpoint.json"
    printf '%s/compact-checkpoint.json\n' "$root"
    ;;
  verify)
    [[ $# -ge 3 ]] || { usage; exit 2; }
    project_slug="$(slugify "$1")"
    require_phase_files "$project_slug" "$2" "$3"
    ;;
  *)
    usage
    exit 2
    ;;
esac
