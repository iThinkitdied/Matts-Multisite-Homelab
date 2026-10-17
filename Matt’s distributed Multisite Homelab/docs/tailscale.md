# Tailscale mesh design

All sites and admin devices join one tailnet. Node identities, IPs, and
owner details are redacted here — see `SECURITY.md`.

## Design

- **Every node** (servers, mini PCs, admin phones/tablets) is a tailnet
  member. Admin is SSH over the tailnet (Termius) plus RustDesk where a GUI
  is needed.
- **legacy-router** is the **subnet router**: it advertises its site LAN to
  the tailnet (routes approved in the Tailscale admin console), so any
  tailnet device can reach LAN hosts at that site.
- **Media and services** are reachable at their tailnet IPs — no port
  forwarding on any residential router.
- **MagicDNS** provides tailnet name resolution between nodes.

## Adding a node

1. Install Tailscale: `curl -fsSL https://tailscale.com/install.sh | sh`
2. Authenticate: `tailscale up` (use a tagged auth key for servers —
   generate at the admin console, store outside git)
3. For a subnet router: `tailscale up --advertise-routes=<LAN_CIDR>`, then
   approve the routes in the admin console.

The Ansible playbook `ansible/playbooks/tailscale.yml` automates this;
the auth key is injected at deploy time, never committed.
