ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

RUN apk add --update --no-cache git jq nodejs nodejs-npm python3 python3-dev && \
    pip3 install PyYAML && \
    git clone -b master --single-branch --depth 1 https://github.com/Koenkk/zigbee2mqtt.git /app

COPY run.sh /app/run.sh
COPY set_config.py /app/set_config.py

WORKDIR /app

RUN ["chmod", "a+x", "/app/run.sh"]
RUN ["npm", "install"]

CMD [ "/app/run.sh" ]
