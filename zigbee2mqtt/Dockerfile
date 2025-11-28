# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM AS base

ENV LANG=C.UTF-8

RUN apk --no-cache add socat tini nodejs eudev tzdata

FROM base AS deps_and_build

ARG ZIGBEE2MQTT_VERSION
RUN \
    apk add --no-cache --virtual .buildtools npm make gcc g++ linux-headers udev git python3 \
    && mkdir -p /app/dist \
    && curl -sSLf -o "/app.tar.gz" "https://github.com/Koenkk/zigbee2mqtt/archive/${ZIGBEE2MQTT_VERSION}.tar.gz" \
    && tar -C /app --strip-components=1 -xzvf "/app.tar.gz" \
    && rm -rf "/app.tar.gz" \
    && echo ${ZIGBEE2MQTT_VERSION} > /app/dist/.hash \
    && cd /app \
    && npm i -g $(jq -r '.packageManager' package.json) \
    && pnpm i --frozen-lockfile --no-optional \
    && pnpm run build \
    && rm -rf node_modules \
    && pnpm i --frozen-lockfile --no-optional --prod \
    # force serialport to rebuild on current platform instead of using prebuilds
    && rm -rf `find ./node_modules/.pnpm/ -wholename "*/@serialport/bindings-cpp/prebuilds" -type d` \
    && pnpm rebuild @serialport/bindings-cpp

FROM base AS release

COPY rootfs /

WORKDIR /app
ENV NODE_ENV=production

COPY --from=deps_and_build /app/node_modules ./node_modules
COPY --from=deps_and_build /app/dist ./dist
COPY --from=deps_and_build /app/package.json /app/LICENSE /app/index.js ./
