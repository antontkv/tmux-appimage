FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -x; \
    apt-get update && \
    apt-get install -y --no-install-recommends git wget tar libevent-dev ncurses-dev build-essential bison pkg-config \
    file automake ca-certificates openssl

RUN set -x; \
    mkdir -p /build/AppDir/usr && \
    cd /build && \
    wget -O linuxdeploy https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage && \
    chmod +x ./linuxdeploy && \
    cd /build/AppDir && \
    wget -O tmux-logo.png https://github.com/tmux/tmux/raw/master/logo/icons/128x128/tmux.png

COPY build.sh /build/build.sh

ENTRYPOINT [ "/bin/bash" ]
CMD [ "/build/build.sh" ]
