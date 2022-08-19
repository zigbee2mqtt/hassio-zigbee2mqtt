# Home Assistant Add-on: Zigbee2MQTT Edge

[![Docker Pulls](https://img.shields.io/docker/pulls/zigbee2mqtt/zigbee2mqtt-edge-amd64.svg?style=flat-square&logo=docker)](https://cloud.docker.com/u/zigbee2mqtt/repository/docker/dwelch2101/zigbee2mqtt-edge-amd64)

⚠️ This is the Edge version (follows the Zigbee2MQTT development branch) ⚠️

Allows you to use your Zigbee devices **without** the vendors bridge or gateway.

It bridges events and allows you to control your Zigbee devices via MQTT. In this way you can integrate your Zigbee devices with whatever smart home infrastructure you are using.

See Documentation tab for more details.

### Updating the Edge add-on
To update the `edge` version of the add-on, you will need to uninstall and re-install the add-on.

⚠️ Make sure to backup your config as the procedure will not save this for you.

**Steps**
1. Backup config from: **Settings → Add-ons → Zigbee2MQTT Edge → Configuration → ⋮ → Edit in YAML**, copy the **Options** somewhere safe
1. Uninstall: **Settings → Add-ons → Zigbee2MQTT Edge → Uninstall**
1. Refresh repo: **Settings → Add-ons → Add-ons store → ⋮ → Check for updates**
1. Install: **Settings → Add-ons → Add-ons store → Zigbee2MQTT Edge → Install**
1. Restore config to: **Settings → Add-ons → Zigbee2MQTT Edge → Configuration → ⋮ → Edit in YAML**, paste your config from step 1.
