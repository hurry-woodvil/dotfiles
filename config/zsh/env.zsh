eval "$(/opt/homebrew/bin/brew shellenv)"

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# rustup
export PATH="$(brew --prefix rustup)/bin:$PATH"

# uv
export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# Secret values should be kept outside dotfiles.
[[ -f "$HOME/.config/zsh/secrets.zsh" ]] && source "$HOME/.config/zsh/secrets.zsh"

typeset -U path PATH
