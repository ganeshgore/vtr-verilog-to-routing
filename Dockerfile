FROM ubuntu:20.04 as builder

RUN apt-get update
RUN apt-get install -y software-properties-common wget

# add auto gpg key other lauchpad ppa
RUN add-apt-repository -y ppa:nilarimogard/webupd8
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test

# add llvm PPA and keys
RUN printf "\n\
deb http://apt.llvm.org/focal llvm-toolchain-focal-13 main \n\
" >> /etc/apt/sources.list
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

RUN apt-get update
RUN apt-get install -y \
    ninja-build \
    libssl-dev \
    autoconf \
    automake \
    bash \
    bison \
    binutils \
    build-essential \
    curl \
    doxygen \
    flex \
    fontconfig \
    gdb \
    git \
    gperf \
    libcairo2-dev \
    libgtk-3-dev \
    libevent-dev \
    libfontconfig1-dev \
    liblist-moreutils-perl \
    libncurses5-dev \
    libx11-dev \
    libxft-dev \
    libxml++2.6-dev \
    perl \
    python-lxml \
    texinfo \
    time \
    valgrind \
    zip \
    qt5-default \
    clang-format-7 \
    g++-7 \
    gcc-7 \
    g++-8 \
    gcc-8 \
    g++-9 \
    gcc-9 \
    g++-10 \
    gcc-10 \
    g++-11 \
    gcc-11 \
    clang-6.0 \
    clang-7 \
    clang-10 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install CMake
WORKDIR /tmp
ENV CMAKE=cmake-3.17.0
RUN curl -s https://cmake.org/files/v3.17/${CMAKE}.tar.gz | tar xvzf -
RUN cd ${CMAKE} && ./configure && make && make install

# Set out workspace
ENV WORKSPACE=/workspace
RUN mkdir -p ${WORKSPACE}
VOLUME ${WORKSPACE}
WORKDIR ${WORKSPACE}

CMD [ "/bin/bash" ]