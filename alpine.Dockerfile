FROM alpine:latest AS builder

RUN --mount=type=cache,target=/var/cache/apk \
    apk update && \
    apk add --no-cache sccache-dist bubblewrap tini envsubst

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/sccache-dist"]
