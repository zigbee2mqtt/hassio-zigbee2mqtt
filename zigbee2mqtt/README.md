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

# WARNING! Breaking Changes Notice
Once upgraded from 1.6.0 to 1.7.0 you cannot switch back to 1.6.0 when not having a backup of the database.db!

If you upgrade from older versions: Version 1.5.1 contains breaking changes! See the documentation on https://github.com/danielwelch/hassio-zigbee2mqtt for more information. The breaking change is from 1.4 to 1.5.1+, therefore, if you have version 1.4 and you are upgrade the version, check the documentation.

# Configuration
The configuration closely mirrors that of `zigbee2mqtt` itself, with a couple of key differences:
1. Hass.io requires add-on configuration in JSON format, rather than YAML. If you don't understand the difference, you can use a YAML-to-JSON converter.
2. An additional top-level `data-path` option is required. Set this to the path where you would like the add-on to persist data. Defaults to `/share/zigbee2mqtt`. Note that both `config` and `share` directories are mapped into the container (read-write) and are available to you.
3. If you are using groups or device-specific settings, you must use seperate files, and provide the paths to these files in their corresponding config options as described by the zigbee2mqtt docs. This is due to a limitation Hass.io places on nested config levels.

See the [zigbee2mqtt configuration docs](https://www.zigbee2mqtt.io/information/configuration.html) for a complete description of available options. If you're not sure if a new option is supported, check to see if it is included in this add-on's default configuration. If not, you can open an issue to add support for it.

# Notes
- Depending on your configuration, the MQTT server config may need to include the port, typically `1883` or `8883` for SSL communications. For example, `mqtt://core-mosquitto:1883` for Hass.io's Mosquitto addon.
- To find out which serial ports you have exposed go to **Supervisor (used to be Hass.io) > System > Host system > Hardware**
- Please see this add-on's [documentation on GitHub](https://github.com/danielwelch/hassio-zigbee2mqtt#socat) for further add-on-specific information (using Socat, how to add support for new devices etc.).

# Additional Configuration Options
- `network_key_string`  
This setting can be used instead of the normal array in case you would like the network key to be read from the secrets file (strings can be read from the secrets file whereas arrays cannot). Please note that `network_key` still needs to be present in the configuration (arrays being mandatory), but it may just be an empty array (it will be overwritten by the contents of `network_key_string` anyway).
- `ext_pan_id_string`  
Extended PAN ID has only been implemented as a string setting instead of an array to allow it to be optional and to not break existing configurations (strings can be optional whereas arrays cannot).

Examples:
```yaml
advanced:
  network_key: []
  network_key_string: '!secret zigbee2mqt_network_key'
  ext_pan_id_string: '221, 221, 221, 221, 221, 221, 221, 221'
```
