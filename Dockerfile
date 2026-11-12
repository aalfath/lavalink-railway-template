# Lavalink 4.2.2, official upstream Alpine variant (Zulu Java 17).
# The default 4.2.2 tag runs Java 18, which crashes on Railway at start
# (NullPointerException in CgroupV2Subsystem), so this template uses -alpine.
FROM ghcr.io/lavalink-devs/lavalink:4.2.2-alpine@sha256:96be2be7ee50d35a9bd42c8c7b99e2a4b741f09123066c1ebb9e014dd7db204d

USER root
COPY application.yml /opt/Lavalink/application.yml
COPY railway-start.sh /usr/local/bin/railway-start.sh
RUN chown lavalink:lavalink /opt/Lavalink/application.yml \
 && chmod 755 /usr/local/bin/railway-start.sh
USER lavalink

ENTRYPOINT ["/usr/local/bin/railway-start.sh"]
