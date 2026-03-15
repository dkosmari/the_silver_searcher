#!/bin/sh

set -e
cd "$(dirname "$0")"

./bootstrap
./configure "$@"
make -j4
