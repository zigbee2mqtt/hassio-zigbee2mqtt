# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM AS base

ENV LANG=C.UTF-8

RUN apk --no-cache add socat tini nodejs eudev tzdata

FROM base AS deps_and_build

# ignore cache for below layers when latest commit changes
ADD "https://api.github.com/repos/Koenkk/zigbee2mqtt/branches/dev" latest_commit
RUN \
    apk add --no-cache --virtual .buildtools npm make gcc g++ linux-headers udev git python3 \
    && git clone -b dev --single-branch --depth 1 https://github.com/Koenkk/zigbee2mqtt.git /app \
    && mkdir -p /app/dist \
    && cd /app \
    && echo $(git rev-parse --short=8 HEAD) > /app/dist/.hash \
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
