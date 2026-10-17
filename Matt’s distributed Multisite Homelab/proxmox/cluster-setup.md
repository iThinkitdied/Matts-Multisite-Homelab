# Proxmox cluster setup

## Create (on mini1)

1. Log into the Proxmox web UI: `https://192.168.1.101:8006`
2. Datacenter → Cluster → **Create Cluster**
3. Cluster name: `homelab` (or whatever you like)
4. Note the join information (IP + fingerprint + join token)

## Join (on mini2, then mini3)

1. Datacenter → Cluster → **Join Cluster**
2. Paste the join information from mini1
3. Enter root password when prompted

## Verify

Datacenter → Cluster should show 3 nodes, all green. Quorum: 3 votes = 2
needed — the cluster survives any single node going down.

## Rules

- All cluster members stay on the same LAN (corosync + latency).
- Removing a node: Datacenter → Cluster → select node → Remove (do this
  *before* wiping a host).
- Never join a node over Tailscale/WAN as a cluster member.

## Templates (next step)

Once base config is solid: create a Debian cloud-init template VM and LXC
templates for fast, identical guest provisioning. Document the template
build in `ansible/` so templates themselves are reproducible.
