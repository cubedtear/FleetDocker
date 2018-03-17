FROM debian:stable as builder

# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#         ca-certificates \
#         git \
#         cmake \
#         build-essential \
#         zlib1g-dev \
#         python \
#         wget \
#         xz-utils


# Update Software repository
RUN apt-get update -y && \
	apt-get install -y --no-install-recommends \
	build-essential \
	pkg-config \
	uuid-dev \
	openjdk-8-jdk \
	python3 \
	cmake \
	wget && \
	rm -rf /var/lib/apt/lists/*


RUN mkdir -p /deps

# llvm
WORKDIR /deps
RUN wget http://releases.llvm.org/6.0.0/llvm-6.0.0.src.tar.xz
RUN tar xf llvm-6.0.0.src.tar.xz
RUN mkdir -p /deps/llvm-6.0.0.src/build
WORKDIR /deps/llvm-6.0.0.src/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/deps/local -DCMAKE_PREFIX_PATH=/deps/local -DCMAKE_BUILD_TYPE=Release
RUN make install -j4

# clang
WORKDIR /deps
RUN wget http://releases.llvm.org/6.0.0/cfe-6.0.0.src.tar.xz
RUN tar xf cfe-6.0.0.src.tar.xz
RUN mkdir -p /deps/cfe-6.0.0.src/build
WORKDIR /deps/cfe-6.0.0.src/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/deps/local -DCMAKE_PREFIX_PATH=/deps/local -DCMAKE_BUILD_TYPE=Release
RUN make install -j4

FROM debian:stable-slim

COPY --from=builder /deps/local /deps/local