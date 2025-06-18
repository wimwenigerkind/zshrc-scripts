fzfdir() {
  dir=$(ls -ld -- */ | fzf | awk '{print $9}')
  if [ -n "$dir" ]; then
    cd "$dir"
  fi
}

alias fd='fzfdir'
