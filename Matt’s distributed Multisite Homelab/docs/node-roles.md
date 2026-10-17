# Node roles

(Role-based naming is used throughout this repo — see `SECURITY.md`.)

## thinkcentre — Site B (primary site)

Linux Mint on a ThinkCentre M73. The workhorse: 25+ containers.

**Media automation** (`docker/arrstack/docker-compose.yml`):
Gluetun (VPN kill-switch) → qBittorrent, Prowlarr, FlareSolverr behind the
tunnel; Radarr, Sonarr, Lidarr, Bazarr, Jellyfin, Seerr on a custom Docker
network with static IPs. Deunhealth restarts qBittorrent if the tunnel
drops.

**Network**: AdGuard Home (DNS/adblock), nginx-proxy-manager
(`docker/network-services/`), Tailscale.

**AI stack** (containerized — see `docker/ai-stack/README.md`): agent
runtimes, vector DB.

**Apps**: photo management, private chat, notes, dashboards, media invite
management, browser-in-Docker.

**System**: CasaOS suite, rclone, RustDesk, SSH, Samba.

## legacy-router — Site A

Pentium E5200, 2GB RAM, antiX (runit) headless. No Docker — everything runs
native.

- **Pi-hole** (official installer; FTL + lighttpd set to start on boot)
- **Glances** web monitor (pip install, runit service)
- **iptables NAT**: forwards Jellyfin (8096) to the ThinkCentre over the
  tailnet; IP forwarding enabled, rules persisted and restored on boot
- Tailscale member; headless conversion done (display manager stripped,
  text-mode boot). Subnet-router role to be confirmed in the admin console.

## mini1 / mini2 / mini3 — 3× mini PC (i5, 16GB), Site A

Proxmox VE cluster (in build). Planned roles:

- **mini1 — prod**: DNS fallback, monitoring, reverse proxy, core
  services. Only tested configs; snapshots before every change.
- **mini2 — AI lab**: local model runtimes, dev work. The compute-heavy box.
- **mini3 — sandbox**: experimental VMs/LXCs, rebuild tests. Never wipe the
  host without removing it from the cluster first.

## partner-gpu — collaborator site (partner-operated)

Proxmox + high-VRAM GPU. Partner's machine — advised on the install, no
code run on it. Part of the Tailscale mesh for AI workloads.
