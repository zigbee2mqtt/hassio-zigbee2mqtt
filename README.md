# WORK IN PROGRESS!

# Hass.io Add-on: zigbee2mqtt

Add-on for running [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt) in [Hass.io](https://github.com/home-assistant/hassio).

## Usage

### Installation

- Add the [repository URL](https://github.com/danielwelch/hassio-zigbee2mqtt) in your Hass.io > Add-on Store

The addon should now be available for installation.

### Configuration
To configure this add-on, you must create a file named `configuration.yaml` within the directory you specify via the `data_path` add-on option. See the [zigbee2mqtt docs](https://github.com/Koenkk/zigbee2mqtt/wiki/Running-the-bridge) and the [default configuration file](https://github.com/Koenkk/zigbee2mqtt/blob/master/data/configuration.yaml) (included below) for more information.

For example, to use the default configuration used in zigbee2mqtt, create the following file in your Hass.io instance at `/share/zigbee2mqtt/configuration.yaml`: 

```yaml
# Home Assistant integration (MQTT discovery)
homeassistant: true

# allow new devices to join
permit_join: true

# MQTT settings
mqtt:
  # MQTT base topic for zigbee2mqtt MQTT messages
  base_topic: zigbee2mqtt
  # MQTT server URL, will need to be changed
  server: 'mqtt://homeassitant'
  # MQTT server authentication, uncomment if required:
  # user: my_user
  # password: my_password

# Serial settings
serial:
  # Location of CC2531 USB sniffer
  port: /dev/ttyACM0

# Advanced configuration
advanced:
  version: 1
  pan_id: 0x1a62
```

|Parameter|Required|Description|
|---------|--------|-----------|
|`data_path`|Yes|Set this to the path you'd like the add-on to persist data. Must be within the `/share` directory. Defaults to `/share/zigbee2mqtt`|

Note: Depending on your configuration, the MQTT server URL is likely to include the internal Docker host IP address (`172.17.0.1`) and the port specified elsewhere, typically `1883` or `8883` for SSL communications. For example, `mqtt://172.17.0.1:1883`.

Warning: Serial `port` can't be changed yet as it's part of the docker mapping:
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
