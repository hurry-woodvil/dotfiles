#!/usr/bin/env zsh

require_command() {
  command -v "$1" >/dev/null 2>&1 || {
    error "required command not found: $1"
    exit 1
  }
}

path_add() {
  local dir="$1"

  if [[ -d "$dir" ]]; then
    path=("$dir" $path)
    typeset -U path PATH
  fi
}
