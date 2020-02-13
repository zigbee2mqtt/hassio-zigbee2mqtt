<div align="center">
<img src="images/logo.png">
<h1>Zigbee2mqtt Hass.io Add-on</h1>
<div style="display: flex; justify-content: center;">
  <a style="margin-right: 0.5rem;" href="https://travis-ci.org/danielwelch/hassio-zigbee2mqtt">
    <img src="https://img.shields.io/travis/danielwelch/hassio-zigbee2mqtt.svg?style=flat-square&logo=travis">
  </a>
  <a style="margin-left: 0.5rem;" href="https://cloud.docker.com/u/dwelch2101/repository/docker/dwelch2101/zigbee2mqtt-armhf">
    <img src="https://img.shields.io/docker/pulls/dwelch2101/zigbee2mqtt-armhf.svg?style=flat-square&logo=docker">
  </a>
</div>
<br>
<p>Run Zigbee2mqtt as a Hass.io Add-on</p>
</div>

## Warning: Breaking Changes in version 1.7.0+
Once upgraded from 1.6.0 to 1.7.0 you cannot switch back to 1.6.0 when not having a backup of the database.db!

## Warning: Breaking Changes in version 1.5.1 
Version 1.5.1 contains breaking changes and requires re-formating of the add-on configuration. Please see the updated configuration documentation below.

#### Restoring Configuration after upgrading to 1.5.1
By default, when upgrading to v1.5.1, the add-on will create a backup of your configuration.yml within your data path: `$DATA_PATH/configuration.yaml.bk`. When upgrading, you should use this to fill in the relevant values into your new config, particularly the network key, to avoid breaking your network and having to repair all of your devices.


## Installation

Add the repository URL via the Hassio Add-on Store Tab: `https://github.com/danielwelch/hassio-zigbee2mqtt`

The repository includes two add-ons: **zigbee2mqtt** and **zigbee2mqtt-edge**. For a stable release that tracks the released versions of zigbee2mqtt, install zigbee2mqtt. zigbee2mqtt-edge tracks the dev branch of zigbee2mqtt, so you can install the edge version if there are features or fixes in the dev branch that are not yet released.

## Configuration

Configure the add-on via the Hass.io front-end. The configuration closely mirrors that of `zigbee2mqtt` itself, with a couple of key differences:
1. Hass.io requires add-on configuration in JSON format, rather than YAML. If you don't understand the difference, you can use a YAML-to-JSON converter.
2. An additional top-level `data-path` option is required. Set this to the path where you would like the add-on to persist data. Defaults to `/share/zigbee2mqtt`. Note that both `config` and `share` directories are mapped into the container (read-write) and are available to you.
3. If you are using groups or device-specific settings, you must use seperate files, and provide the paths to these files in their corresponding config options as described by the zigbee2mqtt docs. This is due to a limitation Hass.io places on nested config levels.

See the [zigbee2mqtt configuration docs](https://www.zigbee2mqtt.io/information/configuration.html) for a complete description of available options. If you're not sure if a new option is supported, check to see if it is included in this repository's `zigbee2mqtt/config.json` or `zigbee2mqtt_edge/config.json` `schema`. If not, you can open an issue to add support for it.

- Depending on your configuration, the MQTT server config may need to include the port, typically `1883` or `8883` for SSL communications. For example, `mqtt://core-mosquitto:1883` for Hass.io's Mosquitto addon.
- To find out which serial ports you have exposed go to **Supervisor (used to be Hass.io) > System > Host system > Hardware**

## Pairing

The suggested way to pair your devices is to enable zigbee2mqtt's `permit_join` option from within Home Assistant using MQTT rather than through the add-on's User Interface. Below is an example configuration that will allow you to enable and disable device pairing from the Home Assistant front end:

<img width="503" alt="screen shot 2018-06-02 at 14 41 42" src="https://user-images.githubusercontent.com/7738048/40874668-bdd1645a-667a-11e8-88ff-03b78212910b.png">

```yaml
mqtt:
  broker: core-mosquitto # This will have to be your mqtt broker, Mosquitto addon is recommended.
  discovery: true

input_boolean:
  zigbee_permit_join:
    name: Allow devices to join
    initial: off
    icon: mdi:cellphone-wireless

timer:
  zigbee_permit_join:
    name: Time remaining
    duration: 600 # Updated this to the number of seconds you wish

sensor:
  - platform: mqtt
    name: Bridge state
    state_topic: "zigbee2mqtt/bridge/state"
    icon: mdi:router-wireless

automation:
  - id: enable_zigbee_join
    alias: Enable Zigbee joining
    hide_entity: true
    trigger:
      platform: state
      entity_id: input_boolean.zigbee_permit_join
      to: 'on'
    action:
    - service: mqtt.publish
      data:
        topic: zigbee2mqtt/bridge/config/permit_join
        payload: 'true'
    - service: timer.start
      data:
        entity_id: timer.zigbee_permit_join
  - id: disable_zigbee_join
    alias: Disable Zigbee joining
    trigger:
    - entity_id: input_boolean.zigbee_permit_join
      platform: state
      to: 'off'
    action:
    - data:
        payload: 'false'
        topic: zigbee2mqtt/bridge/config/permit_join
      service: mqtt.publish
    - data:
        entity_id: timer.zigbee_permit_join
      service: timer.cancel
    hide_entity: true
  - id: disable_zigbee_join_timer
    alias: Disable Zigbee joining by timer
    hide_entity: true
    trigger:
    - platform: event
      event_type: timer.finished
      event_data:
        entity_id: timer.zigbee_permit_join
    action:
    - service: mqtt.publish
      data:
        topic: zigbee2mqtt/bridge/config/permit_join
        payload: 'false'
    - service: input_boolean.turn_off
      data:
        entity_id: input_boolean.zigbee_permit_join
```
And add something like the following to your lovelace YAML file (if using YAML mode):
```yaml
type: entities
entities:
  - entity: input_boolean.zigbee_permit_join
  - entity: timer.zigbee_permit_join
  - entity: sensor.bridge_state
show_header_toggle: false
title: Zigbee
```


Notes:
- `permit_join` will be enabled for 10 minutes (based on code automation)

---
### Updating the Add-on and `zigbee2mqtt` Library

The stable, versioned zigbee2mqtt can be updated using the standard Hass.io update functionality within the user interface. This add-on will be updated with bug fixes and as the underlying `zigbee2mqtt` library is updated.

To update the edge version of the add-on, you will need to uninstall and re-install the add-on. If you have reinstalled the add-on and believe that the latest version has not been installed, try removing the repository before reinstalling.

----
### Socat

In some cases it is not possible to forward a serial device to the container that zigbee2mqtt runs in. This could be because the device is not physically connected to the machine at all. 

Socat can be used to forward a serial device over TCP to zigbee2mqtt. See the [socat man pages](https://linux.die.net/man/1/socat) for more info.

You can configure the socat module within the socat section using the following options:

- `enabled` true/false to enable socat (default: false)
- `master` master or first address used in socat command line (mandatory)
- `slave` slave or second address used in socat command line (mandatory)
- `options` extra options added to the socat command line (optional)
- `log` true/false if to log the socat stdout/stderr to data_path/socat.log (default: false)
- `initialdelay` delay (in seconds) to wait when the plugin is started before zigbee2mqtt is started (optional)
- `restartdelay` delay (in seconds) to wait before a socat process is restarted when it has terminated (optional)

**NOTE:** You'll have to change both the `master` and the `slave` options according to your needs. The defaults values will make sure that socat listens on port `8485` and redirects its output to `/dev/ttyZ2M`. The zigbee2mqtt's serial.port setting is NOT automatically set and has to be changed accordingly.

----
### Adding Support for New Devices
If you are interested in [adding support for new devices to zigbee2mqtt](https://www.zigbee2mqtt.io/how_tos/how_to_support_new_devices.html), set the optional, top-level `zigbee_shepherd_devices` option to `true` in your configuration. When set, the add-on will scan your `data_path` for a `devices.js` file, and will run zigbee2mqtt using this custom file.

----
### Issues

If you find any issues with the addon, please check the [issue tracker](https://github.com/danielwelch/hassio-zigbee2mqtt/issues) for similar issues before creating one. If your issue is regarding specific devices or, more generally, an issue that arises after zigbee2mqtt has successfully started, it should likely be reported in the [zigbee2mqtt issue tracker](https://github.com/Koenkk/zigbee2mqtt/issues)

Feel free to create a PR for fixes and enhancements. 

## Credits
- [danielwelch](https://github.com/danielwelch)
- [ciotlosm](https://github.com/ciotlosm)
- [Koenkk](https://github.com/Koenkk) for [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt)
