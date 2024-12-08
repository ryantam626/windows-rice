#!/bin/bash

set -e

apt_install_quiet="sudo apt -qq -y -o Dpkg::Use-Pty=0 install"
SCRIPT_PATH=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename "$0")")
SCRIPT_DIR=$(dirname $SCRIPT_PATH)/

source $SCRIPT_DIR/_common.sh

info "Installing Docker.\n"
info "[docker] Adding Docker's official GPG key.\n"
sudo apt update
$apt_install_quiet ca-certificates
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

info "[docker] Add the repository to Apt sources.\n"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

info "[docker] Installing Docker and friends.\n"
$apt_install_quiet docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

info "[docker] Add current user to docker group.\n"
sudo usermod -aG docker $USER
