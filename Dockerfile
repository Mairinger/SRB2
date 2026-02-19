FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y build-essential libsdl2-dev git wget && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN make -C src

EXPOSE 5029/udp

CMD ["./src/srb2", "server"]
