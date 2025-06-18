# SSH wrapper to remove host from known_hosts before connecting
function sshdelete() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: sshdelete [user@]hostname [ssh_options]"
    return 1
  fi

  local host_port="${1#*@}"  # Remove username if present
  host_port="${host_port%%:*}"  # Remove port if present
  local host="${host_port%%*}"  # Final clean hostname/IP

  # Remove host from known_hosts
  ssh-keygen -R "$host" &>/dev/null

  # Connect with regular SSH
  #echo "Connecting to $1 (removed from known_hosts)"
  #command ssh "$@"
}
