audit_unmanaged_apps() {
  section "Applications not managed by Homebrew Cask"

  if ! command -v brew >/dev/null 2>&1; then
    print "brew: not found"
    return
  fi

  local -a app_paths
  local -a managed_paths
  local app_path
  local managed_path
  local is_managed

  app_paths=(${(f)"$(find /Applications -maxdepth 1 -name "*.app" -print 2>/dev/null | sort)"})

  managed_paths=(${(f)"$(
    brew info --json=v2 --cask $(brew list --cask) 2>/dev/null \
      | jq -r '.casks[].artifacts[]? | select(type == "object") | .app[]? // empty' \
      | sed 's#^#/Applications/#' \
      | sort -u
  )"})

  for app_path in $app_paths; do
    is_managed=false

    for managed_path in $managed_paths; do
      if [[ "$app_path" == "$managed_path" ]]; then
        is_managed=true
        break
      fi
    done

    if [[ "$is_managed" == false ]]; then
      printf "%-45s %s\n" "${app_path:t:r}" "$app_path"
    fi
  done
}

audit_apps() {
  section "Applications - /Applications"
  [[ -d /Applications ]] &&
    find /Applications -maxdepth 1 -name "*.app" -print 2>/dev/null | sort

  section "Applications - ~/Applications"
  [[ -d "$HOME/Applications" ]] &&
    find "$HOME/Applications" -maxdepth 1 -name "*.app" -print 2>/dev/null | sort
}
