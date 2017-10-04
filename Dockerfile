FROM ubuntu:latest

WORKDIR /root

RUN echo "2017-10-04" && apt-get update && apt-get install -y --no-install-recommends \
  g++ \
  make \
  file \
  curl \
  ca-certificates \
  python \
  git \
  cmake \
  sudo \
  gdb \
  xz-utils \
  jq \
  bzip2
	
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y --no-install-recommends nodejs
	
# Get LLVM WebAssembly-backend binaries instead of trying to compile them for 4+ hours
RUN curl -L https://storage.googleapis.com/wasm-llvm/builds/linux/lkgr.json | jq '.build | tonumber' | tee llvm-build
RUN curl -L https://storage.googleapis.com/wasm-llvm/builds/linux/$(cat llvm-build)/wasm-binaries.tbz2 | \
    tar xvkj
	
RUN curl https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz > emsdk-portable.tar.gz
RUN tar xzf emsdk-portable.tar.gz

WORKDIR /root/emsdk-portable 

RUN ./emsdk update 
RUN ./emsdk install --enable-wasm --build=Release sdk-incoming-32bit
RUN ./emsdk activate --enable-wasm --build=Release sdk-incoming-32bit

RUN echo "LLVM_ROOT='/root/wasm-install/bin'" >> /root/.emscripten

VOLUME ["/src"]
WORKDIR /src