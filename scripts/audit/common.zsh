section() {
  print
  print "========================================"
  print "$1"
  print "========================================"
}

exists() {
  local cmd="$1"
  (( $+commands[$cmd] ))
}

run() {
  local cmd="$1"

  if exists "$cmd"; then
    "$@"
  else
    print "not found: $cmd"
  fi
}
