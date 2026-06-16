audit_brew() {
  section "Homebrew"
  run brew --version

  section "Homebrew Formula - all"
  exists brew && brew list --formula

  section "Homebrew Formula - leaves"
  exists brew && brew leaves

  section "Homebrew Cask"
  exists brew && brew list --cask

  section "Homebrew Services"
  exists brew && brew services list
}
