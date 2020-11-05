ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

ENV ZIGBEE2MQTT_VERSION=1.16.1
ENV ARCHIVE=zigbee2mqtt-$ZIGBEE2MQTT_VERSION

RUN apk add --update --no-cache curl jq nodejs npm socat \
    python2 make gcc g++ linux-headers udev git python2 && \
  curl -sL -o "/$ARCHIVE.tar.gz" \
  "https://github.com/Koenkk/zigbee2mqtt/archive/$ZIGBEE2MQTT_VERSION.tar.gz" && \
  tar xzvf "/$ARCHIVE.tar.gz" && \
  cd "/$ARCHIVE" && \
  jq -n --arg commit $ZIGBEE2MQTT_VERSION '{"hash": $commit }' > .hash.json && \
  npm install --unsafe-perm -g pm2 && \
  npm install --unsafe-perm && \
  apk del make gcc g++ python2 linux-headers udev && \
  rm -rf docs test images scripts data docker LICENSE README.md update.sh

COPY run.sh "/$ARCHIVE/run.sh"
COPY socat.sh "/$ARCHIVE/socat.sh"
WORKDIR "/$ARCHIVE"

RUN ["chmod", "a+x", "./socat.sh"]
RUN ["chmod", "a+x", "./run.sh"]
CMD [ "./run.sh" ]
