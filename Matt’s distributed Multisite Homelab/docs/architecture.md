# Architecture

## Design principles

1. **Cluster lives on one LAN.** Proxmox corosync is latency-sensitive — the
   three mini PCs sit on the same switch at Site A. Remote sites join
   via Tailscale, never as cluster members.
2. **Separate prod from play.** One box runs things that must stay up; one
   is the AI lab; one is the sandbox where things are allowed to break.
3. **Split-tunnel media.** Only torrent traffic rides the VPN (Gluetun
   kill-switch). Media servers and managers stay direct for bandwidth and
   LAN access.
4. **Everything reproducible.** If it isn't in git, it doesn't exist.
5. **Redact by default.** See `SECURITY.md` — identities, secrets, exact
   versions, and live health status never go in the public repo.

## Traffic flow

- Site LAN devices → legacy router node (Pi-hole DNS + Tailscale subnet
  router) → ThinkCentre at Site B over the tailnet.
- qBittorrent/Prowlarr/FlareSolverr are forced through Gluetun. If the VPN
  drops, those containers lose network — nothing leaks. Deunhealth restarts
  qBittorrent automatically on tunnel failure.
- The arr services use static IPs on a custom Docker network
  (`arrnetwork`), so the layout is deterministic across rebuilds.
- Admin access: SSH over Tailscale from phone/tablet, RustDesk where a GUI
  is needed. No port forwarding on any residential router.

## Storage layout (per mini PC, planned)

- **NVMe** — Proxmox OS + VM/LXC virtual disks (fast I/O).
- **2.5" SATA SSD** — bulk storage, added in Proxmox as extra
  directory/LVM storage (media, backups, ISOs).

Single disk per tier, no RAID — these are lab boxes; backups go to the
collaborator's Proxmox host and/or external USB.
