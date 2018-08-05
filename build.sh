#!/bin/bash
set -ev

cp "${TRAVIS_BUILD_DIR}"/zigbee2mqtt/run.sh "${TRAVIS_BUILD_DIR}"/zigbee2mqtt-edge/run.sh
cp "${TRAVIS_BUILD_DIR}"/zigbee2mqtt/set_config.py "${TRAVIS_BUILD_DIR}"/zigbee2mqtt-edge/set_config.py

if [ -z "${TRAVIS_TAG}" ]; then
    echo "Untagged build found. Testing building zigbee2mqtt with tag 'test' and zigbee2mqtt-edge with tag 'test'."
    # build zigbee2mqtt
    docker run -it --rm --privileged --name "${ADDON_NAME}" \
        -v ~/.docker:/root/.docker \
        -v "$(pwd)":/docker \
        hassioaddons/build-env:latest \
        --target "${ADDON_NAME}" \
        --tag-test \
        --all \
        --from "homeassistant/{arch}-base" \
        --author "Daniel Welch <dwelch2102@gmail.com>" \
        --doc-url "${GITHUB_URL}" \
        --login "${DOCKER_USERNAME}" \
        --password "${DOCKER_PASSWORD}" \
        --parallel
    # build zigbee2mqtt-edge
    docker run -it --rm --privileged --name "${ADDON_NAME_EDGE}" \
        -v ~/.docker:/root/.docker \
        -v "$(pwd)":/docker \
        hassioaddons/build-env:latest \
        --target "${ADDON_NAME_EDGE}" \
        --tag-test \
        --all \
        --from "homeassistant/{arch}-base" \
        --author "Daniel Welch <dwelch2102@gmail.com>" \
        --doc-url "${GITHUB_URL}" \
        --login "${DOCKER_USERNAME}" \
        --password "${DOCKER_PASSWORD}" \
        --parallel
else
    echo "New git tagged build found. Testing building zigbee2mqtt with tag 'latest'."
    docker run -it --rm --privileged --name "${ADDON_NAME}" \
        -v ~/.docker:/root/.docker \
        -v "$(pwd)":/docker \
        hassioaddons/build-env:latest \
        --target "${ADDON_NAME}" \
        --tag-latest \
        --all \
        --from "homeassistant/{arch}-base" \
        --author "Daniel Welch <dwelch2102@gmail.com>" \
        --doc-url "${GITHUB_URL}" \
        --login "${DOCKER_USERNAME}" \
        --password "${DOCKER_PASSWORD}" \
        --parallel
fi
echo "Local Docker build successful."
