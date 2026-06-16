#!/usr/bin/env zsh

setopt errexit
setopt nounset
setopt pipefail

ROOT_DIR="${0:A:h:h}"
SOFTWARE_YAML="$ROOT_DIR/inventory/software.yaml"

section() {
  print
  print "========================================"
  print "$1"
  print "========================================"
}

error() {
  print "ERROR: $1"
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || {
    error "required command not found: $1"
    exit 1
  }
}

require_file() {
  [[ -f "$1" ]] || {
    error "required file not found: $1"
    exit 1
  }
}

require_command brew
require_command yq
require_command jq
require_command find
require_command sort
require_file "$SOFTWARE_YAML"

section "Cleanup candidates"

typeset -i candidate_count=0

installed_casks=(${(f)"$(brew list --cask)"})

managed_app_names=(${(f)"$(
  brew info --json=v2 --cask $installed_casks \
    | jq -r '
      .casks[]
      | .artifacts[]
      | select(type == "object")
      | .app[]?
    ' \
    | sed 's/\.app$//' \
    | sort -u
)"})

inventory_homebrew_names=(${(f)"$(
  {
    yq '.applications.homebrew[].name' "$SOFTWARE_YAML"
    yq '.applications.homebrew[].aliases[]' "$SOFTWARE_YAML" 2>/dev/null || true
  } | sort -u
)"})

for name in $inventory_homebrew_names; do
  [[ -z "$name" || "$name" == "null" ]] && continue

  app_path="/Applications/${name}.app"

  [[ -e "$app_path" ]] || continue

  if (( ${managed_app_names[(Ie)$name]} )); then
    continue
  fi

  print
  print "$name"
  print "  App     : $app_path"
  print "  Command : trash ${(q)app_path}"

  ((++candidate_count))
done

section "Result"

if (( candidate_count == 0 )); then
  print "OK   no cleanup candidates"
else
  print "INFO cleanup candidates found: $candidate_count"
  print
  print "This script does not delete anything."
  print "Review the commands above before running them manually."
fi
