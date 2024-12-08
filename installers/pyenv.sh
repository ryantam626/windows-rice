#!/bin/bash

set -e

apt_install_quiet="sudo apt -qq -y -o Dpkg::Use-Pty=0 install"
SCRIPT_PATH=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename "$0")")
SCRIPT_DIR=$(dirname $SCRIPT_PATH)/

source $SCRIPT_DIR/_common.sh
source $SCRIPT_DIR/_versions.sh

info "Installing pyenv.\n"
info "[pyenv] Installing necessary deps for building python.\n"
$apt_install_quiet --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

info "[pyenv] Installing Python $GLOBAL_PYTHON_VER and mark as global.\n"
~/.pyenv/bin/pyenv install $GLOBAL_PYTHON_VER
~/.pyenv/bin/pyenv global $GLOBAL_PYTHON_VER
