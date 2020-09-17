# Setting up
1. Git clone this project into your add-ons folder
2. Remove the `image` key from `hassio-zigbee2mqtt/zigbee2mqtt-edge/config.json` to enable local builds.
3. Add back `"image": "dwelch2101/zigbee2mqtt-edge-{arch}"` to `zigbee2mqtt-edge/config.json` after you're done.

# Upgrading the Zigbee2mqtt version
So you want to bump the zigbee2mqtt version because I'm too slow. Here's how:
1. Change the version number in `zigbee2mqtt/Dockerfile`: `ENV ZIGBEE2MQTT_VERSION="$NEW_VERSION"`
2. Change the version number in `zigbee2mqtt/config.json`: `"version": "$NEW_VERSION"`
3. Add any new configuration options to `zigbee2mqtt/config.json` and `zigbee2mqtt-edge/config.json`.
