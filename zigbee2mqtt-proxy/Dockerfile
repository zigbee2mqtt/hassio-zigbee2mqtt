ARG BUILD_FROM
FROM $BUILD_FROM
RUN apk add --no-cache --update nginx

# Copy root filesystem
ADD nginx.conf.gtpl /
ADD entrypoint.sh /

ENTRYPOINT ["/bin/sh", "-c", "/entrypoint.sh"]
# Build arguments
ARG BUILD_ARCH
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION}

ENTRYPOINT ["/entrypoint.sh"]
