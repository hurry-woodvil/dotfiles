alias rm="trash"
alias vi="nvim"

if command -v eza >/dev/null 2>&1; then
  alias ls="eza"
  alias ll="eza -la"
  alias la="eza -a"
  alias lt="eza --tree"
fi

if command -v bat >/dev/null 2>&1; then
  alias cat="bat"
fi

alias g="git"
alias lg="lazygit"
