FROM buildpack-deps:stretch-scm

WORKDIR /root

RUN echo "01-10-2017" && \
    apt-get update && \
    apt-get install -y --no-install-recommends cmake default-jre python2.7 git-core build-essential
	
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y --no-install-recommends nodejs
	
RUN curl https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz > emsdk-portable.tar.gz
RUN tar xzf emsdk-portable.tar.gz

WORKDIR /root/emsdk-portable 

RUN ./emsdk install --enable-wasm --build=Release sdk-incoming-32bit binaryen-master-32bit
RUN ./emsdk activate --enable-wasm --build=Release sdk-incoming-32bit binaryen-master-32bit

VOLUME ["/src"]
WORKDIR /src