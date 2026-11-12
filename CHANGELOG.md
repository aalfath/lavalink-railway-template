# Changelog

Each entry is one version of this template. Breaking changes are listed first.
Railway shows deployers an "update available" notice when a change lands on `main`;
read the entry before you apply it.

## 4.2.2-1 (2026-11-12)

- First version: Lavalink 4.2.2 (`ghcr.io/lavalink-devs/lavalink:4.2.2-alpine`, pinned by digest
  `sha256:96be2be7ee50d35a9bd42c8c7b99e2a4b741f09123066c1ebb9e014dd7db204d`, Java 17).
- youtube-plugin 1.18.2; Lavalink's built-in YouTube source is off.
- Generated password, refuses to start with an empty one. Java heap capped at 1 GB (override with `JAVA_OPTS`).
- Health check `/metrics` (Prometheus, no password needed).
