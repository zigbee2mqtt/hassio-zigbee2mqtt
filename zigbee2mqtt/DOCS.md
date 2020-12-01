# Home Assistant Add-on: Zigbee2mqtt

## Prerequisites

This add-on currently requires to have an [MQTT broker](https://www.home-assistant.io/docs/mqtt/broker/) installed, whether it is Mosquitto or the default Home Assistant MQTT broker. Please make sure to install and set up that add-on before continuing.

# Pairing
By default the add-on has `permit_join` set to `false`. To allow devices to join you need to activate this **after** the add-on has started. You can now use the [built-in frontend](https://www.zigbee2mqtt.io/information/frontend.html) to achieve this. For details on how to enable the built-in frontent see the next section.

### Enabling the built-in Frontend
Make sure your add-on options have the right settings. If you already had experimental options, you might now automatically get `new_api` set properly on update.

```yaml
frontend:
  port: 8099
experimental:
  new_api: true
```

Enable `ingress` to have the frontend available in your UI: **Supervisor → Dashboard → Zigbee2mqtt → Show in sidebar**. You can find more details about the feature on the [Zigbee2mqtt documentation](https://www.zigbee2mqtt.io/information/frontend.html).

# Configuration
The configuration closely mirrors that of `zigbee2mqtt` itself, with a couple of key differences:
1. An additional top-level `data-path` option is required. Set this to the path where you would like the add-on to persist data. Defaults to `/share/zigbee2mqtt`. Note that both `config` and `share` directories are mapped into the container (read-write) and are available to you.
2. If you are using groups or device-specific settings, you must use seperate files, and provide the paths to these files in their corresponding config options as described by the zigbee2mqtt docs. This is due to a limitation Home Assistant places on nested config levels.

See the [zigbee2mqtt configuration docs](https://www.zigbee2mqtt.io/information/configuration.html) for a complete description of available options. If you're not sure if a new option is supported, check to see if it is included in this add-on's default configuration. If not, you can open an issue to add support for it.

# Notes
- Depending on your configuration, the MQTT server config may need to include the port, typically `1883` or `8883` for SSL communications. For example, `mqtt://core-mosquitto:1883` for Home Assistant's Mosquitto add-on.
- To find out which serial ports you have exposed go to **Supervisor → System → Host system → ⋮ → Hardware**
- Please see this add-on's [documentation on GitHub](https://github.com/danielwelch/hassio-zigbee2mqtt#socat) for further add-on-specific information (using Socat, how to add support for new devices etc.).
- The 'devices' and 'groups' configuration options accept arrays of files since Zigbee2MQTT v1.16.2. In order to maintain backwards compatibility of configurations, the same functionality is achieved in this addon by the use of comma-separated strings.

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

# Socat
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

**NOTE:** You'll have to change both the `master` and the `slave` options according to your needs. The defaults values will make sure that socat listens on port `8485` and redirects its output to `/dev/ttyZ2M`. The zigbee2mqtt's serial port setting is NOT automatically set and has to be changed accordingly.

## :warning: Breaking Changes in version 1.7.0+

Once upgraded from 1.6.0 to 1.7.0 you cannot switch back to 1.6.0 when not having a backup of the database.db!

## :warning: Breaking Changes in version 1.5.1

Version 1.5.1 contains breaking changes and requires re-formating of the add-on configuration. Please see the updated configuration documentation below.

### Restoring Configuration after upgrading to 1.5.1

By default, when upgrading to v1.5.1, the add-on will create a backup of your configuration.yml within your data path: `$DATA_PATH/configuration.yaml.bk`. When upgrading, you should use this to fill in the relevant values into your new config, particularly the network key, to avoid breaking your network and having to repair all of your devices.
