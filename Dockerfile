FROM ubuntu:21.04 as builder
RUN apt-get update &&\
    apt-get install -y \
    ca-certificates \
    git \
    golang

WORKDIR ./src

COPY ./src/go.mod .
COPY ./src/go.sum .

RUN go mod download

COPY ./src .

RUN go build

FROM ubuntu:21.04 as app

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
    apt-get install -y \
    ca-certificates \
    curl \
    apt-transport-https \
    lsb-release \
    gnupg \
    python3 \
    python3-pip

RUN pip install azure-cli

COPY --from=builder /src/rover .
