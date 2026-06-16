audit_languages() {
  section "npm global packages"
  exists npm && npm list -g --depth=0

  section "Cargo installed binaries"
  exists cargo && cargo install --list

  section "Go binaries"
  if exists go; then
    local gopath
    gopath="$(go env GOPATH)"
    print "GOPATH: $gopath"
    [[ -d "$gopath/bin" ]] &&
      find "$gopath/bin" -maxdepth 1 -type f -print 2>/dev/null | sort
  fi

  section "Python pip packages"
  exists pip3 && pip3 list

  section "uv tools"
  exists uv && uv tool list

  section "Ruby gems"
  exists gem && gem list
}
