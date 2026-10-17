#!/usr/bin/env bash
# First-boot bootstrap for a fresh Debian/Proxmox node.
# Run once over SSH before Ansible takes over.
set -euo pipefail

if [ -n "${1:-}" ]; then
  hostnamectl set-hostname "$1"
  echo "Hostname set to $1"
fi

apt-get update
apt-get install -y python3 sudo curl openssh-server

# Harden SSH slightly: key-only for root is set via Proxmox installer;
# ensure your public key is in place before disabling password auth.
echo "Bootstrap done. Add your SSH key, then run the Ansible playbooks."
