FROM rust:bullseye

RUN apt-get update && apt-get install -y \
    sudo \
    software-properties-common \
    build-essential \
    gcc-aarch64-linux-gnu \
    gcc-arm-linux-gnueabihf \
    pkg-config \
    libssl-dev \
    binutils-aarch64-linux-gnu \
    graphviz

# Add to the rust components and cross-compilation target
RUN rustup component add clippy
RUN rustup component add rustfmt
RUN rustup target add aarch64-unknown-linux-gnu

# Install useful tools
RUN cargo install just cargo-modules loc

# Create non-root user "dev"
RUN echo 'root:dev' | chpasswd
RUN useradd -ms /bin/bash dev && echo 'dev:dev' | chpasswd && adduser dev sudo
RUN echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER dev

# Shell customization I can't live without
RUN echo 'PS1="\W \e[01;31m$\e[m "' >> /home/dev/.bashrc
RUN echo 'alias l="ls -lah"' >> /home/dev/.bashrc
RUN echo 'alias gs="git status"' >> /home/dev/.bashrc
COPY --chown=dev:dev .devcontainer/gu /usr/local/bin/gu


