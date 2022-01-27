#!/bin/bash

arch=$(dpkg --print-architecture)

supportedArchs=("arm64" "arm" "386" "amd64")

if [[ ! " ${supportedArchs[*]} " =~ " ${arch} " ]]; then
    printf "Unsupported Arch: $arch" >&2
   exit 1
fi

# Download the latest terraform (arch specific), install to global environment.
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys B36CBA91A2C0730C435FC280B0B441097685B676
TF_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M ".current_version")
curl -k -o terraform.zip https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_${arch}.zip
curl -k -o terraform.sha256 https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_SHA256SUMS
curl -k -o terraform.sha256.sig https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_SHA256SUMS.sig
gpg --verify terraform.sha256.sig terraform.sha256
echo $(grep -Po "[[:xdigit:]]{64}(?=\s+terraform_${TF_VERSION}_linux_${arch}.zip)" terraform.sha256) terraform.zip | sha256sum -c
unzip terraform.zip
unset TF_VERSION
