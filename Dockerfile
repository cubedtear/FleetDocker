#Download base image ubuntu 16.04
FROM buildpack-deps:xenial-scm
MAINTAINER Aritz Lopez <cubedtear@gmail.com>

# Update Software repository
RUN echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial main" | tee -a /etc/apt/sources.list && \
	wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
	apt-get update -y && \
	apt-get install -y --no-install-recommends \
	llvm-6.0-dev \
	build-essential \
	pkg-config \
	uuid-dev \
	openjdk-8-jdk \
	python3 \
	cmake && \
	rm -rf /var/lib/apt/lists/*
