audit_commands() {
  section "Common command locations"

  local commands=(
    zsh
    git
    tmux
    wezterm
    nvim
    vim
    starship
    zoxide
    fzf
    fd
    rg
    eza
    bat
    jq
    yq
    lazygit
    tree
    node
    npm
    pnpm
    yarn
    cargo
    rustc
    go
    python3
    pip3
    docker
    code
  )

  local cmd
  for cmd in "${commands[@]}"; do
    if exists "$cmd"; then
      printf "%-12s %s\n" "$cmd" "$(where "$cmd")"
    else
      printf "%-12s %s\n" "$cmd" "not found"
    fi
  done
}
