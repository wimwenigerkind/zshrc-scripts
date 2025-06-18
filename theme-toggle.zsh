theme:enable() {
  export CS_TERM=true
  echo "CS_TERM=true gesetzt."
  zsh
}

theme:disable() {
  unset CS_TERM
  echo "CS_TERM entfernt."
  zsh
}

