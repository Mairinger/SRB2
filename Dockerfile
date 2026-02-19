FROM ubuntu:22.04

# základní nástroje + závislosti pro SRB2
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        libsdl2-dev \
        libsdl2-mixer-dev \
        git \
        wget \
        libminiupnpc-dev \
        libgme-dev \
        libopenmpt-dev \
        libpng-dev \
        libcurl4-openssl-dev \
        pkg-config \
        zlib1g-dev \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

# Build SRB2
RUN make -C src

EXPOSE 5029/udp

CMD ["./src/srb2", "server"]
