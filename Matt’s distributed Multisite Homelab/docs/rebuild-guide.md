# Rebuild guide — bare metal to running

## 0. What you need

- Proxmox VE ISO on a USB stick (Rufus, same as always)
- The three minis on the same switch at Site A
- This repo + an Ansible control machine (any Linux box, even Termius-local)

## 1. Install Proxmox on each mini

1. Boot the USB installer → install to the **NVMe**.
2. Set hostname: `mini1` / `mini2` / `mini3`, static IP or DHCP reservation
   (`192.168.1.101–103`).
3. Add the 2.5" SSD afterwards: Datacenter → Node → Disks → add as
   Directory storage (or LVM-thin).

## 2. Form the cluster

On **mini1**: Datacenter → Cluster → Create Cluster. Name it, note the join
information.

On **mini2** and **mini3**: Datacenter → Cluster → Join Cluster, paste the
join info from mini1. Three nodes = healthy quorum, no tiebreaker needed.

> Corosync is latency-sensitive: keep all three on the same LAN. Never add a
> WAN/Tailscale node as a cluster member.

## 3. Bootstrap with Ansible

```bash
cd ansible
ansible-playbook -i inventory/hosts.yml playbooks/base.yml
```

Then per role, e.g.:

```bash
ansible-playbook -i inventory/hosts.yml playbooks/tailscale.yml
ansible-playbook -i inventory/hosts.yml playbooks/docker.yml
```

## 4. Deploy services

```bash
cd docker/network-services && docker compose up -d   # pi-hole, etc.
cd ../arrstack && docker compose up -d            # jellyfin + arr stack
```

## 5. Prove it (staging rule)

On mini3, create a fresh LXC, run the playbooks against it, confirm the
service comes up identically. If it doesn't, fix the playbook — not the
server.
