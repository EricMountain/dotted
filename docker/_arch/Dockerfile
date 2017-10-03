FROM scratch

# http://mirrors.kernel.org/archlinux/iso/latest/
# sudo tar -xz --strip-components=1 -f ../archlinux-bootstrap-2017.10.01-x86_64.tar.gz && sudo tar -czf ../archlinux-bootstrap-2017.10.01-x86_64.stripped.tar.gz * && sudo rm -rf *
ADD archlinux-bootstrap-2017.10.01-x86_64.stripped.tar.gz /

RUN pacman-key --init && \
    pacman-key --populate archlinux && \
    perl -p -i -e 's!#Server = http://archlinux.mirrors.ovh.net!Server = http://archlinux.mirrors.ovh.net!' /etc/pacman.d/mirrorlist && \
    pacman -Syu --noconfirm

# docker run --rm -it arch:latest /usr/bin/bash
