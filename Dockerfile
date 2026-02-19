# Dockerfile for SRB2 server

# Base image
FROM ubuntu:22.04

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV SRB2_MAP=MAP01
ENV SRB2_MAXPLAYERS=8
ENV SRB2_PORT=5029

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        libsdl2-dev \
        libsdl2-mixer-dev \
        libpng-dev \
        libcurl4-openssl-dev \
        libminiupnpc-dev \
        libgme-dev \
        libopenmpt-dev \
        pkg-config \
        wget \
        git \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy all files
COPY . /app

# Build the server
RUN make -C src

# Expose UDP port
EXPOSE 5029/udp

# Start the server
CMD ["./src/srb2", "+map", "${SRB2_MAP}", "+maxplayers", "${SRB2_MAXPLAYERS}", "+port", "${SRB2_PORT}"]
