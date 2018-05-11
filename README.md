# WORK IN PROGRESS!

# Hass.io Add-on: zigbee2mqtt

Add-on for running [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt) in [Hass.io](https://github.com/home-assistant/hassio).

## Usage

### Installation

- Add the [repository URL](https://github.com/danielwelch/hassio-zigbee2mqtt) in your Hass.io > Add-on Store

The addon should now be available for installation

### Configuration
Make sure you setup the options correctly. Make sure you restart the addon when change any of the value

- `homeassistant` - set this to true if you want mqtt autodiscovery. See [Integrating with Home Assistant](https://github.com/Koenkk/zigbee2mqtt/wiki/Integrating-with-Home-Assistant) for details
- `permit_join` - set this to `true` when you setup new devices - make sure you set it back to `false` when done
- `mqtt_base_topic` - prefix for your mqtt topic 
- `mqtt_server` - the mqtt server - makes ure you include the protocol. Example: `mqtt://localhost`
- `serial_port` - serial port for your CC2531 stick. Warning: This currently can't be changed as it's part of the docker mapping:
```
  "devices": ["/dev/ttyACM0:/dev/ttyACM0:rwm"]
```

### Issues

This addon is currently still work in progress. If you find any issues with it, please check first the [issue tracker](https://github.com/danielwelch/hassio-zigbee2mqtt/issues). 

Feel free to create a PR for fixes and enhancements. 

## Credits
- [Koenkk](https://github.com/Koenkk) for his [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt)
- [danielwelch]