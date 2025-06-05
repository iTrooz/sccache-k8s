FROM archlinux:latest

# Update system, install packages, and clean up
RUN --mount=type=cache,target=/var/cache/pacman \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
        rust cargo \
        gcc clang \
        sccache bubblewrap

ENTRYPOINT ["/bin/sccache-dist"]
