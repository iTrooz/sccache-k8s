FROM archlinux:latest

# Update system, install packages, and clean up
RUN --mount=type=cache,target=/var/cache/pacman \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm cargo bubblewrap openssl pkg-config

RUN --mount=type=cache,target=/cargo-cache \
    cargo install --git https://github.com/iTrooz/sccache sccache --target-dir /cargo-cache --features="dist-client dist-server"
        
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /usr/local/bin/tini
RUN chmod +x /usr/local/bin/tini

ENTRYPOINT ["/usr/local/bin/tini", "--", "/root/.cargo/bin/sccache-dist"]
