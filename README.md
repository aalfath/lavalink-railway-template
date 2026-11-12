# Lavalink on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/OiWMq-?utm_medium=integration&utm_source=button&utm_campaign=lavalink)

One-click [Lavalink](https://lavalink.dev) 4.2.2 for Discord music bots, with the official youtube-plugin 1.18.2 and a generated password.

## What it deploys

One service, **Lavalink**, built from this repo:

- `Dockerfile`: the official image `ghcr.io/lavalink-devs/lavalink:4.2.2-alpine`, pinned by digest (Java 17), plus `application.yml` and a start script.
  The default `4.2.2` tag runs Java 18, which crashes on Railway at start, so the Alpine variant is used.
- `application.yml`: port 2333 on IPv4 and IPv6, built-in YouTube off, youtube-plugin 1.18.2 (clients `MUSIC`, `ANDROID_VR`, `WEB`, `WEBEMBEDDED`), Bandcamp, SoundCloud, Twitch, Vimeo, Niconico and HTTP sources on, local files off, Prometheus metrics at `/metrics`.
- `railway-start.sh`: refuses to start if the password is empty, caps the Java heap at 1 GB, then runs Lavalink. It's the image's entrypoint, so no start command is needed.

The template itself sets the health check (`/metrics`, which answers without the password), restart on failure, and a public domain on port 2333. There's no `railway.json`: Railway no longer reads Config as Code for new services.

Lavalink keeps no data on disk, so there is no volume and no database.

## Variables

| Variable | Default | What it does |
|---|---|---|
| `LAVALINK_SERVER_PASSWORD` | `${{secret(32)}}` | Password your bot sends. Generated at deploy; Lavalink won't start without one. |
| `PORT` | `2333` | Port Lavalink listens on; the health check and the public domain use it. |
| `JAVA_OPTS` | *(unset → `-Xmx1G -XX:+ExitOnOutOfMemoryError`)* | Optional. Set it to change the Java heap, e.g. `-Xmx2G`. |

Any Lavalink setting can also be overridden with an environment variable, using Spring's naming, for example `PLUGINS_YOUTUBE_OAUTH_ENABLED=true` or `LAVALINK_PLUGINS_0_DEPENDENCY=dev.lavalink.youtube:youtube-plugin:<version>`.

## Connect your bot

| Bot runs | Host | Port | Secure | Password |
|---|---|---|---|---|
| Anywhere | the service's Railway domain | 443 | true | `LAVALINK_SERVER_PASSWORD` |
| Same Railway project | `lavalink.railway.internal` | 2333 | false | `LAVALINK_SERVER_PASSWORD` |

## Updates

When this repo's `main` changes (a new Lavalink or plugin release, for example), Railway shows projects deployed from the template an "update available" notice. Nothing changes until you apply it. Read [CHANGELOG.md](CHANGELOG.md) first.
