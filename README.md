# WORK IN PROGRESS!

# Hass.io Add-on: zigbee2mqtt

Add-on for running [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt) in [Hass.io](https://github.com/home-assistant/hassio).

## Usage

### Installation

- Add the [repository URL](https://github.com/danielwelch/hassio-zigbee2mqtt) in your Hass.io > Add-on Store

The addon should now be available for installation.

### Configuration
To configure this add-on, you must set the following parameters via the Hass.io user interface. See the [zigbee2mqtt docs](https://github.com/Koenkk/zigbee2mqtt/wiki/Running-the-bridge) and the [default configuration file](https://github.com/Koenkk/zigbee2mqtt/blob/master/data/configuration.yaml) for more information.


|Parameter|Type|Required|Description|
|---------|--------|-----------|
|`data_path`|string|Yes|Set this to the path you'd like the add-on to persist data. Must be within the `/share` directory. Defaults to `/share/zigbee2mqtt`.|
|`homeassistant`|bool|yes|Set this to `true` if you want MQTT autodiscovery. See [Integrating with Home Assistant](https://github.com/Koenkk/zigbee2mqtt/wiki/Integrating-with-Home-Assistant) for details.|
|`permit_join`|bool|yes|Set this to `true` when you setup new devices - make sure you set it back to `false` when done.|
|`mqtt_server`|string|yes|Prefix for your MQTT topic|
|`mqtt_base_topic`|string|yes|The MQTT server address. Make sure you include the protocol. Example: `mqtt://homeassistant`|
|`serial_port`|string|yes|Serial port for your CC2531 stick.|
|`mqtt_user`|string|no|Your MQTT username, if set.|
|`mqtt_pass`|string|no|Your MQTT Password, if set.|

Note: Depending on your configuration, the MQTT server URL is likely to include the internal Docker host IP address (`172.17.0.1`) and the port specified elsewhere, typically `1883` or `8883` for SSL communications. For example, `mqtt://172.17.0.1:1883`.

Warning: `port` can't be changed yet as it's part of the docker mapping:
```
  "devices": ["/dev/ttyACM0:/dev/ttyACM0:rwm"]
```

### Issues

This addon is currently still work in progress. If you find any issues with it, please check first the [issue tracker](https://github.com/danielwelch/hassio-zigbee2mqtt/issues). 

Feel free to create a PR for fixes and enhancements. 

## Credits
- [danielwelch](https://github.com/danielwelch)
- [ciotlosm](https://github.com/ciotlosm)
- [Koenkk](https://github.com/Koenkk) for [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt)
