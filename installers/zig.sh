#!/bin/bash

set -e

SCRIPT_PATH=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename "$0")")
SCRIPT_DIR=$(dirname $SCRIPT_PATH)/

source $SCRIPT_DIR/_common.sh

info "Installing Zig.\n"

info "[zig] Downloading zig\n"
mkdir -p ~/apps
curl -s https://ziglang.org/builds/zig-linux-x86_64-0.14.0-dev.3086+b3c63e5de.tar.xz | tar -xJf - -C ~/apps/

info "[zig] Clone and compile zls\n"
pushd ~/apps
git clone https://github.com/zigtools/zls
pushd zls
zig build -Doptimize=ReleaseSafe
cp ./zig-out/bin/zls ~/.local/bin
