# AI stack (containerized)

Installed via the CasaOS app store, so there are no hand-written compose
files — documented here from a live `docker ps`. Exact image versions are
redacted (see `SECURITY.md`); use current stable tags when reproducing.

| Purpose | Ports |
|---------|-------|
| AI agent runtime (OpenClaw-style) | 18790, 24190→18789 |
| Agent runtime (Hermes-style) | 8642, 9119 |
| Vector DB (Qdrant-style, RAG/memory for agents) | 6333–6334 |
| Notes app (+ Postgres) | 1111 |
| Photo management (+ MariaDB) | 2342 |
| Private chat server | 3009→3000 |
| Dashboard | 4000→8080 |
| Media invite management (jfa-go style) | 8056 |
| Browser in Docker (KasmVNC) | 6902→6901 |

To reproduce: install via CasaOS app store, or convert each to a compose
file under this directory following the arrstack pattern.
