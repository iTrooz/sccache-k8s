FROM archlinux:latest

# Update system, install packages, and clean up
RUN --mount=type=cache,target=/var/cache/pacman \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
        rust cargo \
        gcc clang \
        bubblewrap openssl pkg-config

RUN --mount=type=cache,target=/cargo-cache \
    cargo install --git https://github.com/iTrooz/sccache sccache --target-dir /cargo-cache --features="dist-client dist-server"

ENTRYPOINT ["/root/.cargo/bin/sccache-dist"]
