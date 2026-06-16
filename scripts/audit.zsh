#!/usr/bin/env zsh

setopt nounset
setopt pipefail

SCRIPT_DIR="${0:A:h}"
AUDIT_DIR="$SCRIPT_DIR/audit"

source "$AUDIT_DIR/common.zsh"
source "$AUDIT_DIR/system.zsh"
source "$AUDIT_DIR/brew.zsh"
source "$AUDIT_DIR/apps.zsh"
source "$AUDIT_DIR/languages.zsh"
source "$AUDIT_DIR/commands.zsh"
source "$AUDIT_DIR/paths.zsh"
source "$AUDIT_DIR/editors.zsh"

audit_system
audit_brew
audit_apps
audit_unmanaged_apps
audit_languages
audit_commands
audit_paths
audit_editors

section "Audit completed"
