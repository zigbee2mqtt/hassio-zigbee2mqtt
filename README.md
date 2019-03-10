<div align="center">
<img src="https://github.com/Koenkk/zigbee2mqtt/blob/master/images/logo.png?raw=true"/>
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


## Installation

Add the repository URL via the Hassio Add-on Store Tab: `https://github.com/danielwelch/hassio-zigbee2mqtt`

The repository includes two add-ons: **zigbee2mqtt** and **zigbee2mqtt-edge**. For a stable release that tracks the released versions of zigbee2mqtt, install zigbee2mqtt. zigbee2mqtt-edge tracks the dev branch of zigbee2mqtt, so you can install the edge version if there are features or fixes in the dev branch that are not yet released.

## Configuration

The following table describes all available options. To run this add-on, you must set the **required** parameters via the Hass.io user interface. See the [zigbee2mqtt docs](https://www.zigbee2mqtt.io/configuration/configuration.html) and the [default configuration file](https://github.com/Koenkk/zigbee2mqtt/blob/master/data/configuration.yaml) for more information.

|Parameter|Type|Required|Description|
|---------|----|--------|-----------|
|`data_path`|string|yes|Set this to the path you'd like the add-on to persist data. Must be within the `/share` directory. Defaults to `/share/zigbee2mqtt`.|
|`homeassistant`|bool|yes|Set this to `true` if you want MQTT autodiscovery. See [Integrating with Home Assistant](https://www.zigbee2mqtt.io/integration/home_assistant.html) for details.|
|`permit_join`|bool|yes|Recommended to leave this to `false` and use [runtime pairing](https://github.com/danielwelch/hassio-zigbee2mqtt#pairing). Set this to `true` when you setup new devices - make sure you set it back to `false` when done.|
|`mqtt_server`|string|yes|The MQTT server address. Make sure you include the protocol. Example: `mqtt://homeassistant`|
|`mqtt_base_topic`|string|yes|Prefix for your MQTT topic|
|`serial_port`|string|yes|Serial port for your CC2531 stick.|
|`network_key`|list(int)|yes|Specify an encryption key for your zigbee network. See [this section of the Zigbee2mqtt docs](https://www.zigbee2mqtt.io/how_tos/how_to_secure_network.html) for more details and example usage. Leave this option empty (i.e. leave the default) if you don't want to use a network key. Note that changing this requires repairing of all device connections. Hex values are not supported, only integer values (although hex values can be used by manually editing your `configuration.yaml` file and disabling `overwrite`).|
|`devices`|list(object)|yes|See section regarding device-specific configuration below. Leave this empty if not using device-sepcific configuration.|
|`disable_led`|bool|no|Disable the LED of your CC2531 stick.|
|`mqtt_user`|string|no|Your MQTT username, if set.|
|`mqtt_pass`|string|no|Your MQTT Password, if set.|
|`include_device_information`|bool|no|Include device information to mqtt messages (default: false)|
|`report`|bool|no|Enable [the state reporting feature](https://www.zigbee2mqtt.io/information/report.html) of zigbee2mqtt|
|`reject_unauthorized`|bool|no|Disable self-signed SSL certificates|
|`log_level`|enum|no|Set to `debug`, `info`, `warn`, or `error`. Defaults to `info`. The log level for zigbee-shepherd and zigbee2mqtt. See [the wiki](https://www.zigbee2mqtt.io/how_tos/how_to_debug.html) for more information.|
|`log_directory`|string|no|If set, zigbee2mqtt will store logs in this directory. The directory will be a sub-directory of the `data_path` in `/share` (set above). This option must be set to a directory (for example: `"log_directory": "logs/"` will store logs in `/share/zigbee2mqtt/logs/` by default).|
|`pan_id`|string|no|Optional ZigBee pan ID|
|`channel`|int|no|Optional Zigbee Channel|
|`rtscts`|bool|no|RTS / CTS Hardware Flow Control for serial port|
|`cache_state`|bool|no|Optional state caching. See [here](https://github.com/Koenkk/zigbee2mqtt/commit/9396bde1f3b022e0f634487d1a37d2a5127c8cb3#diff-f68567477d803b49930337bf7fe1556bR16).|
|`soft_reset_timeout`|int|no|Soft reset ZNP after timeout (in seconds); 0 is disabled|
|`availability_timeout`|int|no|Availability timeout in seconds, disabled by default (0). When enabled, devices will be checked if they are still online.|
|`last_seen`|str|no|Add a `last_seen` attribute to MQTT messages, contains date/time of last Zigbee message. Possible values are: `disable` (default), `ISO_8601`, `epoch`|
|`elapsed`|bool|no|Add an `elapsed` attribute to MQTT messages, contains milliseconds since the previous message|
|`overwrite`|bool|no|Set this to `false` to disable overwriting any configuration defined in the zigbee2mqtt configuration YAML file when the add-on starts. Useful if you want to manually alter your `configuration.yaml` file. By default, this is set to `true`, meaning any options set in the Hass.io frontend will replace their corresponding entry in the configuration file, if present.|
|`zigbee_shepherd_debug`|bool|no|Set to `true` to enable `zigbee_shepherd` debug output in the logs/stdout.|
|`zigbee_shepherd_devices`|bool|no|If set to `true`, the add-on will look for a custom `devices.js` file within `data_path`. If this file is present, the add-on will replace the zigbee2mqtt `devices.js` file with this file. Used to experiment with and/or add support for new devices.|

- Depending on your configuration, the MQTT server URL will need to include the port, typically `1883` or `8883` for SSL communications. For example, `mqtt://homeassistant:1883`.
- To find out which serial ports you have exposed go to **Hass.io > System > Host system > Show Hardware**

#### Device-specific Configuration

Zigbee2mqtt allows certain [device-specific configuration options](https://www.zigbee2mqtt.io/configuration/device_specific_configuration.html). These can be configured in the add-on via the `devices` option. If you aren't using this feature, you can leave the `devices` option empty as it appears by default. See below for anexample device-specific configuration entry, adapted from the Zigbee2mqtt docs:

```json
"devices": [
  {
    "id": "0x00158d0001d82999",
    "friendly_name": "my_occupancy_sensor",
    "retain": true,
    "occupancy_timeout": 20,
    "qos": 1
  }
]
```
`temperature_precision`, `humidity_precision`, and `pressure_precision` are also supported.


#### Modifying zigbee2mqtt's `configuration.yaml`
In some cases, you may wish to modify zigbee2mqtt's `configuration.yaml` file directly (for example, to add or modify [device specific configuration](https://www.zigbee2mqtt.io/configuration/device_specific_configuration.html)). The `configuration.yaml` file used by this add-on can be modified within the data directory specified via the add-on configuration (see above). By default, therefore, the configuration file is saved to `/share/zigbee2mqtt/configuration.yaml` on your Hass.io host. Suggested ways to edit your `configuration.yaml` file include the official [Samba share](https://www.home-assistant.io/addons/samba/) add-on and the [official](https://www.home-assistant.io/addons/ssh/) or [community SSH add-ons](https://github.com/hassio-addons/addon-ssh).

- Note: Be sure to set the `overwrite` option to `false` if you want to manually modify your configuration file. Otherwise, the settings defined via the Hass.io frontend will overwrite and replace their respective fields in the configuration file on add-on startup.

---
### Pairing

The suggested way to pair your devices is to enable zigbee2mqtt's `permit_join` option from within Home Assistant using MQTT rather than through the add-on's User Interface. Below is an example configuration that will allow you to enable and disable device pairing from the Home Assistant front end:

<img width="503" alt="screen shot 2018-06-02 at 14 41 42" src="https://user-images.githubusercontent.com/7738048/40874668-bdd1645a-667a-11e8-88ff-03b78212910b.png">

```yaml
mqtt:
  broker: homeassistant # This will have to be your mqtt broker
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
### Issues

If you find any issues with the addon, please check the [issue tracker](https://github.com/danielwelch/hassio-zigbee2mqtt/issues) for similar issues before creating one. If your issue is regarding specific devices or, more generally, an issue that arises after zigbee2mqtt has successfully started, it should likely be reported in the [zigbee2mqtt issue tracker](https://github.com/Koenkk/zigbee2mqtt/issues)

Feel free to create a PR for fixes and enhancements. 

## Credits
- [danielwelch](https://github.com/danielwelch)
- [ciotlosm](https://github.com/ciotlosm)
- [Koenkk](https://github.com/Koenkk) for [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt)
