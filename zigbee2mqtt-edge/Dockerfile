ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

RUN apk add --update --no-cache jq nodejs nodejs-npm python3 python3-dev \
        python2 make gcc g++ linux-headers udev git && \
        git clone -b dev --single-branch --depth 1 https://github.com/Koenkk/zigbee2mqtt.git /app

COPY run.sh /app/run.sh
COPY set_config.py /app/set_config.py
COPY requirements.txt /app/requirements.txt

RUN pip3 install --no-cache-dir -r /app/requirements.txt

WORKDIR /app

RUN ["chmod", "a+x", "/app/run.sh"]
RUN ["npm", "install", "--unsafe-perm", "-g", "pm2"]
RUN ["npm", "install", "--unsafe-perm"]
RUN apk del make gcc g++ python2 linux-headers udev

CMD [ "/app/run.sh" ]
