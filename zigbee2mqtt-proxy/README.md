# Home Assistant Add-on: Zigbee2MQTT Proxy

[![Docker Pulls](https://img.shields.io/docker/pulls/zigbee2mqtt/zigbee2mqtt-proxy-amd64.svg?style=flat-square&logo=docker)](https://cloud.docker.com/u/zigbee2mqtt/repository/docker/dwelch2101/zigbee2mqtt-proxy-amd64)

⚠️ This add-on does not contain Zigbee2MQTT ⚠️

This add-on acts as a proxy to an external running Zigbee2MQTT instance. 
The sole purpose of this add-on is to add a Zigbee2MQTT icon to the sidebar of Home Assistant which will open the frontend of an external running Zigbee2MQTT instance.

## Options

- `server` (required): this should be the local URL on which the Zigbee2MQTT frontend is running, e.g. `http://192.168.2.43:8080`. Make sure there is no trailing slash!
- `auth_token` (optional): only use when you have an `auth_token` set for the frontend in the Zigbee2MQTT configuration.