# Base image
FROM ubuntu:22.04

# Instalace potřebných nástrojů a knihoven
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

# Pracovní složka
WORKDIR /app

# Zkopíruj celý repozitář
COPY . /app

# Build SRB2
RUN make -C src

# Port, kam se připojují hráči
EXPOSE 5029/udp

# Environment variables pro mapu a max hráčů
ENV SRB2_MAP=1
ENV SRB2_MAXPLAYERS=8
ENV SRB2_PORT=5029

# CMD - automaticky najde spustitelný soubor
CMD ["bash", "-c", "exec $(find ./src -type f -executable -name 'srb2*') server +map $SRB2_MAP +maxplayers $SRB2_MAXPLAYERS +port $SRB2_PORT"]
