ARG BUILD_FROM
FROM $BUILD_FROM

ARG COMMIT
ENV COMMIT=$COMMIT

# Add env
ENV LANG C.UTF-8

RUN apk add --update --no-cache \
    jq nodejs nodejs-npm socat \
    make gcc g++ linux-headers udev git python2 && \
  git clone -b dev --single-branch --depth 1 https://github.com/Koenkk/zigbee2mqtt.git /app && \
  cd /app && \
  jq -n --arg commit $(eval git rev-parse --short HEAD) '{"hash": $commit }' > /app/.hash.json && \
  echo "Installed zigbee2mqtt @ version $(eval git rev-parse --short HEAD)" && \
  npm install --unsafe-perm -g pm2 && \
  npm install --unsafe-perm && \
  apk del make gcc g++ linux-headers git python2 && \
  rm -rf /app/docs /app/test /app/images /app/scripts /app/data /app/docker /app/LICENSE /app/README.md /app/update.sh

COPY run.sh /app/run.sh
COPY socat.sh /app/socat.sh
WORKDIR /app

RUN ["chmod", "a+x", "./socat.sh"]
RUN ["chmod", "a+x", "./run.sh"]
CMD [ "./run.sh" ]
