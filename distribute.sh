#!/bin/bash
set -ev

cp "${TRAVIS_BUILD_DIR}"/zigbee2mqtt/run.sh "${TRAVIS_BUILD_DIR}"/zigbee2mqtt-edge/run.sh
cp "${TRAVIS_BUILD_DIR}"/zigbee2mqtt/set_config.py "${TRAVIS_BUILD_DIR}"/zigbee2mqtt-edge/set_config.py

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
    echo "This build is a pull request, aborting distribution script."
    exit 0
fi

if [ ! -z "$TRAVIS_TAG" ]; then
    echo "Tagged build found. Pushing zigbee2mqtt image to Docker with tag 'latest'."

    docker run -it --rm --privileged --name "${ADDON_NAME}" \
        -v ~/.docker:/root/.docker \
        -v "$(pwd)":/docker \
        hassioaddons/build-env:latest \
        --target "${ADDON_NAME}" \
        --tag-latest \
        --push \
        --all \
        --from "homeassistant/{arch}-base" \
        --author "Daniel Welch <dwelch2102@gmail.com>" \
        --doc-url "${GITHUB_URL}" \
        --login "${DOCKER_USERNAME}" \
        --password "${DOCKER_PASSWORD}" \
        --parallel
else
    echo "No tag found. Pushing zigbee2mqtt and zigbee2mqtt-edge images to Docker with tag 'test'."

    # distribute zigbee2mqtt with tag test
    docker run -it --rm --privileged --name "${ADDON_NAME}" \
        -v ~/.docker:/root/.docker \
        -v "$(pwd)":/docker \
        hassioaddons/build-env:latest \
        --target "${ADDON_NAME}" \
        --tag-latest \
        --push \
        --all \
        --from "homeassistant/{arch}-base" \
        --author "Daniel Welch <dwelch2102@gmail.com>" \
        --doc-url "${GITHUB_URL}" \
        --login "${DOCKER_USERNAME}" \
        --password "${DOCKER_PASSWORD}" \
        --parallel

    # distribute zigbee2mqtt-edge with tag test
    docker run -it --rm --privileged --name "${ADDON_NAME_EDGE}" \
        -v ~/.docker:/root/.docker \
        -v "$(pwd)":/docker \
        hassioaddons/build-env:latest \
        --target "${ADDON_NAME_EDGE}" \
        --tag-test \
        --push \
        --all \
        --from "homeassistant/{arch}-base" \
        --author "Daniel Welch <dwelch2102@gmail.com>" \
        --doc-url "${GITHUB_URL}" \
        --login "${DOCKER_USERNAME}" \
        --password "${DOCKER_PASSWORD}" \
        --parallel
fi
