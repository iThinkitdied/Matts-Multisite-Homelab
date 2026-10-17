# Network

## Site A LAN (cluster network)

- AT&T fiber gateway → gigabit switch → mini1, mini2, mini3, legacy-router.
- Give the minis **DHCP reservations or static IPs** — cluster membership
  hates IP changes. Suggested: `192.168.1.101–103`.
- If the gateway is short on ports, any cheap gigabit switch ($15–20) works.
  No special interconnect needed — the cluster is pure software over the LAN.

## Tailnet (Tailscale)

Every node and both remote sites join the same tailnet:

| Host | Tailnet role |
|------|--------------|
| mini1/2/3 | Members |
| legacy-router | **Subnet router** — advertises `192.168.1.0/24` so tailnet devices reach the site LAN |
| thinkcentre | Member (Jellyfin reachable at its tailnet IP) |
| partner-gpu | Member |

Enable on the subnet router: `tailscale up --advertise-routes=192.168.1.0/24`, then
approve the routes in the Tailscale admin console.

## DNS

- Pi-hole on the legacy router node — site LAN DNS points at it for
  ad-blocking.
- A Pi-hole instance on mini1 (planned) serves as DNS fallback.
- Tailscale MagicDNS handles tailnet name resolution between sites.
