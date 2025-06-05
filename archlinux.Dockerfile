FROM archlinux:latest

# Update system, install packages, and clean up
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
        rust cargo \
        gcc clang \
        sccache && \
    pacman -Scc --noconfirm && rm -rf /var/cache/pacman

ENTRYPOINT ["/bin/sccache-dist"]
