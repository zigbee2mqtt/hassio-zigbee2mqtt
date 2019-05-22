ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

COPY requirements.txt /requirements.txt

RUN apk add --update --no-cache \
    jq nodejs>10.14.2 npm python3 python3-dev \
    python2 make gcc g++ linux-headers udev git && \
  git clone -b dev --single-branch --depth 1 https://github.com/Koenkk/zigbee2mqtt.git /app && \
  cp /requirements.txt /app/requirements.txt && \
  pip3 install --no-cache-dir -r /app/requirements.txt && \
  cd /app && \
  echo "Installed zigbee2mqtt @ version $(eval git rev-parse --short HEAD)" && \
  npm install --unsafe-perm -g pm2 && \
  npm install --unsafe-perm && \
  apk del make gcc g++ python2 linux-headers udev git

COPY run.sh /app/run.sh
COPY set_config.py /app/set_config.py

RUN ["chmod", "a+x", "/app/run.sh"]
WORKDIR /app
CMD [ "/app/run.sh" ]
