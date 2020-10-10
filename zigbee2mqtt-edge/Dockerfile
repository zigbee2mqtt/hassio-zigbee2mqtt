ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV ZIGBEE2MQTT_VERSION=dev

RUN apk add --update --no-cache \
    jq nodejs-npm socat \
    make gcc g++ linux-headers udev git python2 && \
    git clone -b dev --single-branch --depth 1 \
    https://github.com/Koenkk/zigbee2mqtt.git /app && \
    jq -n --arg commit $(eval cd /app;git rev-parse --short HEAD) '{"hash": $commit }' > /app/.hash.json && \
    echo "Installed zigbee2mqtt @ version $(cat /app/.hash.json)" && \
    cd /app && \
    npm install --unsafe-perm -g pm2 && \
    npm install --unsafe-perm && \
    apk del make gcc g++ python2 linux-headers udev git && \
    rm -rf docs test images scripts data docker LICENSE README.md update.sh

COPY run.sh /app/run.sh
COPY socat.sh /app/socat.sh
WORKDIR /app

RUN ["chmod", "a+x", "./socat.sh"]
RUN ["chmod", "a+x", "./run.sh"]
CMD [ "./run.sh" ]
