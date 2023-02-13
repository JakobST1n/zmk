#!/bin/bash
BOARD="$1"
ARGS="$2"

echo "BOARD: $BOARD"
echo "ARGS: $ARGS"

set -x
docker build -t zmk-dev -f ./.devcontainer/Dockerfile ./.devcontainer
docker run -w /zmk -v "$PWD:/zmk" zmk-dev west init -l app
docker run -w /zmk -v "$PWD:/zmk" zmk-dev west update
docker run -w /zmk -v "$PWD:/zmk" zmk-dev west update zephyr-export
docker run -w /zmk/app -v "$PWD:/zmk" zmk-dev west build -b $BOARD $ARGS
