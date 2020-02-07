<!-- If this pull request updates the version of the stable version of the add-on, please complete the checklist below. Otherwise, please delete it. -->

#### Checklist

- [ ] Change the version number in `zigbee2mqtt/Dockerfile`: `ENV ZIGBEE2MQTT_VERSION="$NEW_VERSION"`
- [ ] Change the version number in `zigbee2mqtt/config.json`: `"version": "$NEW_VERSION"`
- [ ] Add any new configuration options to `zigbee2mqtt/config.json` and `zigbee2mqtt-edge/config.json`.
- [ ] Update the changelog, including any breaking changes, changes to underlying libraries, or new configuration options
