ARG BUILD_FROM
FROM $BUILD_FROM as base

ENV LANG C.UTF-8
ARG BUILD_VERSION

RUN apk add --no-cache socat tini nodejs eudev

FROM base

RUN apk add --no-cache --virtual .buildtools npm make gcc g++ linux-headers udev git python3

COPY rootfs /
RUN chmod 777 /docker-entrypoint.sh

WORKDIR /app

ENV NODE_ENV production

ENTRYPOINT [ "/sbin/tini", "--", "/docker-entrypoint.sh"]
