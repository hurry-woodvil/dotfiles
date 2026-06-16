audit_system() {
  section "System"

  print "User   : $USER"
  print "Shell  : $SHELL"
  print "Zsh    : $(where zsh)"
  print "Arch   : $(uname -m)"

  if command -v sw_vers >/dev/null 2>&1; then
    print "macOS  : $(sw_vers -productVersion)"
  fi

  section "PATH"
  print -l ${(s/:/)PATH}
}
