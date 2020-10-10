# Home Assistant Add-on: Zigbee2mqtt Edge

[![Docker Pulls](https://img.shields.io/docker/pulls/zigbee2mqtt/zigbee2mqtt-edge-amd64.svg?style=flat-square&logo=docker)](https://cloud.docker.com/u/zigbee2mqtt/repository/docker/dwelch2101/zigbee2mqtt-edge-amd64)

⚠️ This is the Edge version ⚠️

Allows you to use your Zigbee devices **without** the vendors bridge or gateway.

It bridges events and allows you to control your Zigbee devices via MQTT. In this way you can integrate your Zigbee devices with whatever smart home infrastructure you are using.

See Documentation tab for more details.

### Updating the Edge add-on
To update the `edge` version of the add-on, you will need to uninstall and re-install the add-on.

⚠️ Make sure to backup your config as the procedure will not save this for you.

**Steps**
- Backup config from: **Supervisor → Dashboard → Zigbee2mqtt Edge → Configuration**
- Uninstall: **Supervisor → Dashboard → Zigbee2mqtt Edge → Uninstall**
- Refresh repo: **Supervisor → Add-on store → ⋮ → Reload**
- Re-install: **Supervisor → Add-on store → Zigbee2mqtt Edge → Install**
- Restore config to: **Supervisor → Dashboard → Zigbee2mqtt Edge → Configuration**
