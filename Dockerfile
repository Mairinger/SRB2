# Base image
FROM ubuntu:22.04

# Závislosti
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

# Environment Variables (nastaví se v Coolify)
ENV SRB2_MAP=1
ENV SRB2_MAXPLAYERS=8
ENV SRB2_PORT=5029

# Spuštění serveru
CMD ["bash", "-c", "ls -l src && find src -type f -executable"]
