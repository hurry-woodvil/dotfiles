#!/usr/bin/env zsh

setopt errexit
setopt nounset
setopt pipefail

DOTFILES_DIR="${${(%):-%x}:A:h}"
CONFIG_DIR="$DOTFILES_DIR/config"
SCRIPTS_DIR="$DOTFILES_DIR/scripts"
ZSH_DIR="$SCRIPTS_DIR/zsh"

BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

source "$ZSH_DIR/utils.zsh"
source "$ZSH_DIR/log.zsh"

backup_if_needed() {
  local target="$1"

  if [[ ! -e "$target" && ! -L "$target" ]]; then
    return
  fi

  if [[ -L "$target" ]]; then
    local link_to="$(readlink "$target")"

    if [[ "$link_to" == "$DOTFILES_DIR"* ]]; then
      rm "$target"
      return
    fi
  fi

  local relative_target="${target#$HOME/}"
  local backup_target="$BACKUP_DIR/$relative_target"

  mkdir -p "${backup_target:h}"

  warn "backup: $target -> $backup_target"
  mv "$target" "$backup_target"
}

link_path() {
  local src="$1"
  local dest="$2"

  if [[ ! -e "$src" ]]; then
    error "path not found: $src"
    exit 1
  fi

  mkdir -p "${dest:h}"
  backup_if_needed "$dest"

  ln -s "$src" "$dest"
  info "link: $dest -> $src"
}

link_config_dir() {
  local name="$1"

  link_path "$CONFIG_DIR/$name" "$HOME/.config/$name"
}

install_homebrew_packages() {
  if [[ ! -f "$DOTFILES_DIR/Brewfile" ]]; then
    warn "Brewfile not found. skip brew bundle."
    return
  fi

  require_command brew

  info "run brew bundle"
  brew bundle --file "$DOTFILES_DIR/Brewfile"
}

link_zsh() {
  link_config_dir zsh
  link_path "$HOME/.config/zsh/zshrc" "$HOME/.zshrc"
}

link_starship() {
  link_path "$CONFIG_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
}

link_wezterm() {
  link_config_dir wezterm
}

link_tmux() {
  link_config_dir tmux
  link_path "$HOME/.config/tmux/tmux.conf" "$HOME/.tmux.conf"
}

link_karabiner() {
  link_config_dir karabiner
}

link_gh() {
  link_config_dir gh
}

link_nvim() {
  link_config_dir nvim
}

main() {
  install_homebrew_packages

  link_zsh
  link_starship
  link_wezterm
  link_tmux
  link_karabiner
  link_gh
  link_nvim

  success "dotfiles bootstrap completed"
}

main "$@"
