#!/bin/bash
set -ev

if [ ! -z ${TRAVIS_TAG} ]; then
    echo "Tagged build found. Pushing to Docker with tag 'latest'."
else
    # DIFF="$(git diff HEAD^ HEAD dropbox-sync)"
    # if [ -z $DIFF ]; then
    #     echo "No changes in Dropbox Sync add-on. Skipping docker push."
    #     exit 0
    # fi
    echo "No tag found. Pushing to Docker with tag 'test'."
fi

git status

echo "$DOCKER_PASSWORD" | docker login -u ${DOCKER_USERNAME} --password-stdin
docker run -it --rm --privileged --name "${ADDON_NAME}" \
    -v ~/.docker:/root/.docker \
    -v "$(pwd)":/docker \
    hassioaddons/build-env:latest \
    --target "${ADDON_NAME}" \
    --git \
    --all \
    --push \
    --from "homeassistant/{arch}-base" \
    --author "Daniel Welch <dwelch2102@gmail.com>" \
    --doc-url "${GITHUB_URL}"
