ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ARG BUILD_VERSION

RUN apk add --no-cache --virtual .build-dependencies \
    make gcc g++ linux-headers udev git python2 && \
    apk add --no-cache jq nodejs npm socat

RUN if [ "${BUILD_VERSION}" = "edge" ]; \
    then \
        echo "Installing Edge version" && \
        git clone -b dev --single-branch --depth 1 \
        https://github.com/Koenkk/zigbee2mqtt.git /app && \
        mkdir /app/dist && \
        jq -n --arg commit $(eval cd /app;git rev-parse --short HEAD) '$commit' > /app/dist/.hash ; \
    else \
        echo "Installing Stable version ${BUILD_VERSION%-*}" && \
        curl -sL -o "/app.tar.gz" \
        "https://github.com/Koenkk/zigbee2mqtt/archive/${BUILD_VERSION%-*}.tar.gz" && \
        tar xzvf "/app.tar.gz"  && rm "/app.tar.gz" && \
        mv -v "zigbee2mqtt-${BUILD_VERSION%-*}" app && \
        mkdir /app/dist && \
        jq -n --arg commit ${BUILD_VERSION%-*} '$commit' > /app/dist/.hash ; \
    fi; \
    echo "Installed zigbee2mqtt @ version $(cat /app/dist/.hash)"

RUN cd /app && \
    npm ci --no-audit --no-optional --no-update-notifier --unsafe-perm && \
    npm run build && \
    rm -rf node_modules && \
    npm ci --no-audit --no-optional --no-update-notifier --only=production --unsafe-perm && \
    apk del --no-cache --purge .build-dependencies && \
    rm -rf docs test images scripts data docker LICENSE README.md update.sh lib && \
    rm -rf npm-shrinkwrap.json \
          node-modules/zigbee-herdsman/npm-shrinkwrap.json \
          node-modules/zigbee-herdsman-converters/npm-shrinkwrap.json && \
    rm -rf /root/.cache /root/.npm

COPY rootfs /
