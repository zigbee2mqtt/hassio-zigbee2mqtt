# Setting up
1. Git clone this project into your add-ons folder
2. Remove the `image` key from `hassio-zigbee2mqtt/zigbee2mqtt-edge/config.json` to enable local builds.
3. Add back `"image": "dwelch2101/zigbee2mqtt-edge-{arch}"` to `zigbee2mqtt-edge/config.json` after you're done.

# Upgrading the Zigbee2mqtt version
So you want to bump the zigbee2mqtt version because I'm too slow. Here's how:
1. Change the version number in `zigbee2mqtt/config.json`: `"version": "$NEW_VERSION"`
2. Update `zigbee2mqtt/CHANGELOG.md`
3. Commit the changes to `dev` branch
4. Publish a new "Release". Very important you specify Target: dev. Example
```
Tag version: v1.17.1  @ Target: dev
Release title: v1.17.1
```
5. When the pipelines finish the [build](https://dev.azure.com/zigbee2mqtt/Zigbee2mqtt%20Add-on/_build?definitionId=10) create a PR to `master`
6. Use **Squash and Merge** option
