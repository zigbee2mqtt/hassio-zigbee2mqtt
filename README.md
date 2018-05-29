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

Note: Depending on your configuration, the MQTT server URL will need to include the port, typically `1883` or `8883` for SSL communications. For example, `mqtt://homeassistant:1883`.

Note: To find out which serial ports you have exposed go to **Hass.io > System > Host system > Show Hardware**

### Pairing

To allow pairing in a better way, it's recommended you leave `permit_join` to false, and use the following code to get a pairing button inside **Home Assistant**:

```
input_boolean:
  zigbee_permit_join:
    name: Allow Zigbee joining
    initial: off
    icon: mdi:cellphone-wireless

mqtt:
  broker: homeassistant # This will have to be your mqtt broker
  discovery: true


automation:
  - alias: Enable Zigbee joining
    trigger:
       platform: state
       entity_id: input_boolean.zigbee_permit_join
       to: 'on'
    action:
      - service: mqtt.publish
        data:
          topic: zigbee2mqtt/bridge/config/permit_join
          payload: "true"
  - alias: Disable Zigbee joining
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

### Issues

This addon is currently still work in progress. If you find any issues with it, please check first the [issue tracker](https://github.com/danielwelch/hassio-zigbee2mqtt/issues). 

Feel free to create a PR for fixes and enhancements. 

## Credits
- [danielwelch](https://github.com/danielwelch)
- [ciotlosm](https://github.com/ciotlosm)
- [Koenkk](https://github.com/Koenkk) for [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt)
