ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

ENV ZIGBEE2MQTT_VERSION=1.4.0
ENV ARCHIVE=zigbee2mqtt-$ZIGBEE2MQTT_VERSION

COPY requirements.txt /requirements.txt

RUN apk add --update --no-cache curl jq nodejs>10.14.2 npm python3 python3-dev \
    python2 make gcc g++ linux-headers udev git && \
  curl -sL -o "/$ARCHIVE.tar.gz" \
  "https://github.com/Koenkk/zigbee2mqtt/archive/$ZIGBEE2MQTT_VERSION.tar.gz" && \
  tar xzvf "/$ARCHIVE.tar.gz" && \
  cp /requirements.txt "/$ARCHIVE/requirements.txt" && \
  pip3 install --no-cache-dir -r "/$ARCHIVE/requirements.txt" && \
  cd "/$ARCHIVE" && \
  npm install --unsafe-perm -g pm2 && \
  npm install --unsafe-perm && \
  apk del make gcc g++ python2 linux-headers udev git

COPY run.sh /$ARCHIVE/run.sh
COPY set_config.py /$ARCHIVE/set_config.py
COPY README.md /$ARCHIVE/README.md
WORKDIR /$ARCHIVE

RUN ["chmod", "a+x", "./run.sh"]
CMD [ "./run.sh" ]
