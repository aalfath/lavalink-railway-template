#!/bin/sh
# Start Lavalink on Railway.
# - Refuses to start without a password: upstream lets an empty Authorization
#   header through when the password is empty, which would leave an open node.
# - Caps the Java heap at 1 GB by default. The JVM can't see Railway's memory
#   limit and would otherwise size itself from the host. Override with JAVA_OPTS.
set -e

if [ -z "$LAVALINK_SERVER_PASSWORD" ]; then
  echo "LAVALINK_SERVER_PASSWORD is empty; refusing to start an open Lavalink node" >&2
  exit 1
fi

cd /opt/Lavalink
exec java ${JAVA_OPTS:--Xmx1G -XX:+ExitOnOutOfMemoryError} -jar /opt/Lavalink/Lavalink.jar
