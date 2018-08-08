FROM debian:stable-slim

# The mkdir is to avoi errors from installing openjdk
# See: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
RUN mkdir -p /usr/share/man/man1 && \
    apt update -y && \
    apt install -y --no-install-recommends wget gnupg ca-certificates && \
    echo "deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch-6.0 main" > /etc/apt/sources.list.d/llvm.list && \
    echo "deb-src http://apt.llvm.org/stretch/ llvm-toolchain-stretch-6.0 main" >> /etc/apt/sources.list.d/llvm.list && \
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key| apt-key add - && \
    apt update && \
    apt install -y --no-install-recommends \
    llvm-6.0-dev \
    lld-6.0 cmake \
    build-essential \
    pkg-config \
    uuid-dev \
    openjdk-8-jdk \
    python3 \
    lld-6.0-dev \
    libz-dev && \
    rm -rf /var/lib/apt/lists/*
