ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

ENV ZIGBEE2MQTT_VERSION=0.2.0
ENV ARCHIVE=zigbee2mqtt-$ZIGBEE2MQTT_VERSION

RUN apk add --update --no-cache curl jq nodejs nodejs-npm python3 python3-dev \
        python2 make gcc g++ linux-headers udev git && \
        pip3 install PyYAML
        
RUN curl -sL -o "/$ARCHIVE.tar.gz" \
    "https://github.com/Koenkk/zigbee2mqtt/archive/$ZIGBEE2MQTT_VERSION.tar.gz" && \
    tar xzvf "/$ARCHIVE.tar.gz" -C /

COPY run.sh /$ARCHIVE/run.sh
COPY set_config.py /$ARCHIVE/set_config.py

WORKDIR /$ARCHIVE

RUN ["chmod", "a+x", "./run.sh"]
RUN ["npm", "install", "--unsafe-perm", "-g", "pm2"]
RUN ["npm", "install", "--unsafe-perm"]
RUN apk del make gcc g++ python2 linux-headers udev

CMD [ "./run.sh" ]
