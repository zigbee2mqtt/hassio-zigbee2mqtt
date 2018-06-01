# Hass.io Add-on: zigbee2mqtt

Add-on for running [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt) in [Hass.io](https://github.com/home-assistant/hassio).

## Usage

### Installation

- Add the [repository URL](https://github.com/danielwelch/hassio-zigbee2mqtt) in your **Hass.io > Add-on Store**

The addon should now be available for installation.

### Configuration

To configure this add-on, you must set the following parameters via the Hass.io user interface. See the [zigbee2mqtt docs](https://github.com/Koenkk/zigbee2mqtt/wiki/Running-the-bridge) and the [default configuration file](https://github.com/Koenkk/zigbee2mqtt/blob/master/data/configuration.yaml) for more information.

|Parameter|Type|Required|Description|
|---------|----|--------|-----------|
|`data_path`|string|Yes|Set this to the path you'd like the add-on to persist data. Must be within the `/share` directory. Defaults to `/share/zigbee2mqtt`.|
|`homeassistant`|bool|yes|Set this to `true` if you want MQTT autodiscovery. See [Integrating with Home Assistant](https://github.com/Koenkk/zigbee2mqtt/wiki/Integrating-with-Home-Assistant) for details.|
|`permit_join`|bool|yes|Set this to `true` when you setup new devices - make sure you set it back to `false` when done.|
|`mqtt_server`|string|yes|Prefix for your MQTT topic|
|`mqtt_base_topic`|string|yes|The MQTT server address. Make sure you include the protocol. Example: `mqtt://homeassistant`|
|`serial_port`|string|yes|Serial port for your CC2531 stick.|
|`mqtt_user`|string|no|Your MQTT username, if set.|
|`mqtt_pass`|string|no|Your MQTT Password, if set.|
|`debug`|bool|no|Set to true to enable debug mode for zigbee-shepherd and zigbee2mqtt. See [the wiki](https://github.com/Koenkk/zigbee2mqtt/wiki/How-to-debug) for more information.|
|`err`|bool|no|Set to true to redirect zigbee2mqtt `stdout` to `out.log` and `stderr` to `err.log`. Both `out.log` and `err.log` will be located within `data_path` above.|
|`commit`|string|no|Set this to a specific `zigbee2mqtt` commit SHA hash to use a specific version of `zigbee2mqtt` (in case of regressions)|

Notes:
- Depending on your configuration, the MQTT server URL will need to include the port, typically `1883` or `8883` for SSL communications. For example, `mqtt://homeassistant:1883`.
- To find out which serial ports you have exposed go to **Hass.io > System > Host system > Show Hardware**

### Pairing

The suggested way to pair your devices is to enable zigbee2mqtt's `permit_join` option from within Home Assistant using MQTT rather than through the add-on's User Interface. Below is an example configuration that will allow you to enable and disable device pairing from the Home Assistant front end:

<img width="500" alt="screen shot 2018-06-01 at 18 29 45" src="https://user-images.githubusercontent.com/7738048/40849401-8898bbc2-65ca-11e8-80d3-98e11b8f41bd.png">

```yaml
input_boolean:
  zigbee_permit_join:
    name: Allow Zigbee joining
    initial: off
    icon: mdi:cellphone-wireless

mqtt:
  broker: homeassistant # This will have to be your mqtt broker
  discovery: true

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
          payload: "true"
  - id: disable_zigbee_join
    alias: Disable Zigbee joining
    hide_entity: true
    trigger:
       platform: state
       entity_id: input_boolean.zigbee_permit_join
       to: 'off'
    action:
      - service: mqtt.publish
        data:
          topic: zigbee2mqtt/bridge/config/permit_join
          payload: "false"
```
Note: There is a [gist](https://gist.github.com/ciotlosm/59d160ad49c695a801d9a940a2a387d2) with the above code


### Updating the Add-on and `zigbee2mqtt` Library

Currently, `zigbee2mqtt` is adding new features and functionality quite quickly, and is not using versioned releases. This makes it difficult to increment versioning for this add-on, as we simply pull the latest master branch when building the Docker image. Until `zigbee2mqtt` stabilizes, we will likely not use versioned releases. Therefore, in order to update the add-on and to update `zigbee2mqtt`, you must uninstall and reinstall the add-on via the Hassio UI.

Note: If you have reinstalled the add-on and believe that the latest version has not been installed, try removing the repository before reinstalling.

### Issues

If you find any issues with the addon, please check first the [issue tracker](https://github.com/danielwelch/hassio-zigbee2mqtt/issues).

Feel free to create a PR for fixes and enhancements. 

## Credits
- [danielwelch](https://github.com/danielwelch)
- [ciotlosm](https://github.com/ciotlosm)
- [Koenkk](https://github.com/Koenkk) for [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt)
