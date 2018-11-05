#!/bin/bash
set -ev

echo "Running local build test."


# build zigbee2mqtt
docker run -it --rm --privileged --name "zigbee2mqtt" \
    -v ~/.docker:/root/.docker \
    -v "$(pwd)":/docker \
    hassioaddons/build-env:latest \
    --target "zigbee2mqtt" \
    --tag-test \
    --armhf \
    --from "homeassistant/{arch}-base" \
    --author "Daniel Welch <dwelch2102@gmail.com>" \
    --doc-url "https://github.com/danielwelch/hassio-zigbee2mqtt" \
    --parallel
