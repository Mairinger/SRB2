FROM ubuntu:22.04

RUN apt update && apt install -y \
    build-essential \
    libsdl2-dev \
    libsdl2-mixer-dev \
    libpng-dev \
    libcurl4-openssl-dev \
    libminiupnpc-dev \
    libgme-dev \
    libopenmpt-dev \
    zlib1g-dev \
    wget \
    unzip

WORKDIR /app

COPY . .

RUN make -C src -j$(nproc)

# stáhne oficiální data
RUN wget https://github.com/STJr/SRB2/releases/latest/download/srb2.pk3

RUN mkdir -p bin
RUN mv srb2.pk3 bin/

EXPOSE 5029/udp

CMD ["./bin/lsdl2srb2", "-dedicated", "-server", "-port", "5029"]
