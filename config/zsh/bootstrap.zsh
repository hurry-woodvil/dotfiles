source "$HOME/.config/zsh/env.zsh"
source "$HOME/.config/zsh/options.zsh"
source "$HOME/.config/zsh/plugins.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/keybinds.zsh"

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
