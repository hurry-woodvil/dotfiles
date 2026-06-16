#!/usr/bin/env zsh

setopt errexit
setopt nounset
setopt pipefail

ROOT_DIR="${0:A:h:h}"
SOFTWARE_YAML="$ROOT_DIR/inventory/software.yaml"

typeset -i failure_count=0

section() {
  print
  print "========================================"
  print "$1"
  print "========================================"
}

info() {
  print "INFO : $1"
}

warn() {
  print "WARN : $1"
}

error() {
  print "ERROR: $1"
}

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    error "required command not found: $1"
    exit 1
  fi
}

require_file() {
  [[ -f "$1" ]] || {
    error "required file not found: $1"
    exit 1
  }
}

require_command brew
require_command yq
require_command find
require_command sort

require_file "$SOFTWARE_YAML"

section "Doctor"

info "software: $SOFTWARE_YAML"

#
# Homebrew
#

section "Homebrew casks"

expected_casks=(${(f)"$(yq '.applications.homebrew[].package' "$SOFTWARE_YAML")"})
installed_casks=(${(f)"$(brew list --cask)"})

for cask in $expected_casks; do
  [[ -z "$cask" || "$cask" == "null" ]] && continue

  if (( ${installed_casks[(Ie)$cask]} )); then
    print "OK   $cask"
  else
    print "MISS $cask"
    ((++failure_count))
  fi
done

#
# Application path
#

section "Application paths"

expected_paths=(${(f)"$(yq '
[
  .applications.app_store[],
  .applications.manual[],
  .applications.macos[]
]
| .[]
| .path
' "$SOFTWARE_YAML")"})

for app_path in $expected_paths; do
  [[ -z "$app_path" ]] && continue

  if [[ -e "$app_path" ]]; then
    print "OK   ${app_path:t}"
  else
    print "MISS ${app_path:t}"
    ((++failure_count))
  fi
done

#
# Unknown
#

section "Unknown applications"

known_names=(${(f)"$(
  {
    yq '.applications.homebrew[].name' "$SOFTWARE_YAML"
    yq '.applications.homebrew[].aliases[]' "$SOFTWARE_YAML" 2>/dev/null

    yq '.applications.app_store[].name' "$SOFTWARE_YAML"
    yq '.applications.app_store[].aliases[]' "$SOFTWARE_YAML" 2>/dev/null

    yq '.applications.manual[].name' "$SOFTWARE_YAML"
    yq '.applications.manual[].aliases[]' "$SOFTWARE_YAML" 2>/dev/null

    yq '.applications.macos[].name' "$SOFTWARE_YAML"
    yq '.applications.macos[].aliases[]' "$SOFTWARE_YAML" 2>/dev/null
  } | sort -u
)"})

installed_apps=(${(f)"$(find /Applications -maxdepth 1 -name '*.app' | sort)"})

unknown_count=0

for app_path in $installed_apps; do
  app_name="${app_path:t:r}"

  if (( ${known_names[(Ie)$app_name]} )); then
    continue
  fi

  print "UNKNOWN ${app_name}"
  ((++unknown_count))
done

if (( unknown_count == 0 )); then
  print "OK   none"
else
  failure_count=$((failure_count + unknown_count))
fi

#
# PATH
#

section "PATH duplicates"

typeset -A seen

duplicate=0

for p in ${(s/:/)PATH}; do
  if [[ -n ${seen[$p]-} ]]; then
    print "DUP  $p"
    ((++duplicate))
  else
    seen[$p]=1
  fi
done

if (( duplicate == 0 )); then
  print "OK   none"
fi

#
# Result
#

section "Result"

if (( failure_count == 0 )); then
  print "OK   doctor passed"
else
  print "FAIL doctor found $failure_count issue(s)"
  exit 1
fi
