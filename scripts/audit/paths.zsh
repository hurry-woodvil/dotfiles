audit_paths() {
  section "Executables in ~/.local/bin"
  [[ -d "$HOME/.local/bin" ]] &&
    find "$HOME/.local/bin" -maxdepth 1 -type f -perm -111 -print 2>/dev/null | sort

  section "Executables in ~/.cargo/bin"
  [[ -d "$HOME/.cargo/bin" ]] &&
    find "$HOME/.cargo/bin" -maxdepth 1 -type f -perm -111 -print 2>/dev/null | sort

  section "Executables in ~/go/bin"
  [[ -d "$HOME/go/bin" ]] &&
    find "$HOME/go/bin" -maxdepth 1 -type f -perm -111 -print 2>/dev/null | sort

  section "LaunchAgents - user"
  [[ -d "$HOME/Library/LaunchAgents" ]] &&
    find "$HOME/Library/LaunchAgents" -maxdepth 1 -name "*.plist" -print 2>/dev/null | sort

  section "LaunchDaemons - system"
  [[ -d /Library/LaunchDaemons ]] &&
    find /Library/LaunchDaemons -maxdepth 1 -name "*.plist" -print 2>/dev/null | sort
}
