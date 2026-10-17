# SECURITY.md — redaction policy

This repo is public. The following are **never** committed here:

1. **Secrets** — VPN credentials, Tailscale auth keys, passwords, API keys.
   Services read them from a `.env` file that is gitignored. Compose files
   reference `${VARIABLES}` only.
2. **Tailnet identities** — node IPs, hostnames, and owner details from
   `tailscale status`. Docs use role-based names (`thinkcentre`,
   `legacy-router`). The tailnet is private; its map stays private.
3. **Exact image versions** — version pins help attackers match CVEs. Docs
   name the software; deployments pin versions in a **private** overlay, not
   here.
4. **Live security posture** — what's currently broken, down, or degraded
   (e.g. a dead VPN tunnel, an offline subnet router) is useful to an
   attacker and embarrassing in a portfolio. Health status lives in private
   ops notes, never in git.
5. **Personal data** — emails, usernames, and anything identifying family
   members or collaborators.

## What's fine to publish

- **Private IP ranges** (192.168.x.x, 172.16.x.x) — not routable from the
  internet; every home network looks like this.
- **Default ports** (8096, 5055, 53…) — public knowledge.
- **Architecture and configs** with secrets templated out — this is the
  entire point of the repo.

## Rule of thumb

If it's an identity, a secret, or a live vulnerability — it doesn't go in
git. When in doubt, redact.
