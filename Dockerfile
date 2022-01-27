FROM ubuntu:21.04 as builder

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&\
    apt-get install -y \
    ca-certificates \
    git \
    golang \
    gnupg \
    software-properties-common \
    curl \
    unzip \
    jq \
    sudo

WORKDIR /src

COPY ./src/go.mod .
COPY ./src/go.sum .

RUN go mod download

COPY ./src .

RUN go build

WORKDIR /porcelain/binaries
COPY ./porcelain /porcelain
RUN sudo cat /porcelain/install_terraform.sh | bash

FROM ubuntu:21.04 as app

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
    apt-get install -y \
    ca-certificates \
    curl \
    apt-transport-https \
    git

COPY --from=builder /src/rover /usr/local/bin/rover
COPY --from=builder /porcelain/binaries/terraform /usr/local/bin/terraform
