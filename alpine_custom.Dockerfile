FROM rust:alpine AS builder

RUN --mount=type=cache,target=/var/cache/apk \
    apk add --no-cache pkgconfig openssl-dev openssl-libs-static

ARG CACHEKEY
RUN --mount=type=cache,target=/cache/target \
    --mount=type=cache,target=/root/.cargo \
    cargo install --locked \
      --features dist-server \
      --root /opt/sccache \
      --target-dir /cache/target \
      --git https://github.com/iTrooz/sccache \
      -f sccache

FROM alpine:latest

RUN --mount=type=cache,target=/var/cache/apk \
    apk add --no-cache bubblewrap tini envsubst

COPY --from=builder /opt/sccache/bin/sccache-dist /usr/bin/sccache-dist

VOLUME /volume

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/sccache-dist"]
