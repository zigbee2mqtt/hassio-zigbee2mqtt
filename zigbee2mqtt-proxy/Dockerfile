# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

RUN \
    apk --no-cache add nginx tzdata \
    && mkdir -p /run/nginx \
    && rm -rf /tmp/* /etc/nginx

COPY rootfs /
