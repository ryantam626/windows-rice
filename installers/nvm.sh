#!/bin/bash

set -e

SCRIPT_PATH=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename "$0")")
SCRIPT_DIR=$(dirname $SCRIPT_PATH)/

source $SCRIPT_DIR/_common.sh
source $SCRIPT_DIR/_versions.sh

info "Installing nvm.\n"
git clone https://github.com/nvm-sh/nvm.git ~/.nvm
