if command -v zinit >/dev/null 2>&1; then
  source "$(brew --prefix zinit)/zinit.zsh"

  zinit light zsh-users/zsh-autosuggestions
  zinit light zsh-users/zsh-syntax-highlighting
fi

if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v ng >/dev/null 2>&1; then
  source <(ng completion script)
fi
