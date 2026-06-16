audit_editors() {
  section "VS Code extensions"
  exists code && code --list-extensions

  section "Neovim lazy plugins"
  [[ -d "$HOME/.local/share/nvim/lazy" ]] &&
    find "$HOME/.local/share/nvim/lazy" -maxdepth 1 -mindepth 1 -type d -print 2>/dev/null | sort
}
