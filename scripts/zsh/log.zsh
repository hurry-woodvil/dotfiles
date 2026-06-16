#!/usr/bin/env zsh

log() {
  local level="$1"
  shift

  case "$level" in
    INFO)
      print -P "%F{blue}[INFO]%f $*"
      ;;
    WARN)
      print -P "%F{yellow}[WARN]%f $*"
      ;;
    ERROR)
      print -P "%F{red}[ERROR]%f $*"
      ;;
    SUCCESS)
      print -P "%F{green}[SUCCESS]%f $*"
      ;;
  esac
}

info() { log INFO "$@"; }
warn() { log WARN "$@"; }
error() { log ERROR "$@"; }
success() { log SUCCESS "$@"; }
