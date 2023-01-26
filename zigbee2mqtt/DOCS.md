# Pairing
By default the add-on has `permit_join` set to `false`. To allow devices to join you need to activate this after the add-on has started. You can now use the [built-in frontend](https://www.zigbee2mqtt.io/information/frontend.html) to achieve this. For details on how to enable the built-in frontent see the next section.

# Enabling the built-in frontend
Enable `ingress` to have the frontend available in your UI: **Settings → Add-ons → Zigbee2MQTT → Show in sidebar**. You can find more details about the feature on the [Zigbee2MQTT documentation](https://www.zigbee2mqtt.io/information/frontend.html).

# Configuration
Configuration required to startup Zigbee2MQTT is available from the addon configuration. The rest of the options can be configured via the Zigbee2MQTT frontend.

# Configuration backup
The add-on will create a backup of your configuration.yml within your data path: `$DATA_PATH/configuration.yaml.bk`. When upgrading, you should use this to fill in the relevant values into your new config, particularly the network key, to avoid breaking your network and having to repair all of your devices.
The backup of your configuration is created on add-on startup if no previous backup was found. 

# Enabling zigbee-herdsman debug logging
If you want to troubleshoot in more depth problems with your zigbee devices, sometimes you must enable DEBUG option on Zigbee2MQTT startup. To do this you must set `zigbee_herdsman_debug` to `true`.

```yaml
zigbee_herdsman_debug: true
```

# Adding Support for New Devices
If you are interested in adding support for new devices to Zigbee2MQTT see [How to support new devices](https://www.zigbee2mqtt.io/how_tos/how_to_support_new_devices.html).

# Notes
- Depending on your configuration, the MQTT server config may need to include the port, typically `1883` or `8883` for SSL communications. For example, `mqtt://core-mosquitto:1883` for Home Assistant's Mosquitto add-on.
- To find out which serial ports you have exposed go to **Supervisor → System → Host system → ⋮ → Hardware**

# Socat
In some cases it is not possible to forward a serial device to the container that zigbee2mqtt runs in. This could be because the device is not physically connected to the machine at all. 

Socat can be used to forward a serial device over TCP to zigbee2mqtt. See the [socat man pages](https://linux.die.net/man/1/socat) for more info.

You can configure the socat module within the socat section using the following options:

- `enabled` true/false to enable socat (default: false)
- `master` master or first address used in socat command line (mandatory)
- `slave` slave or second address used in socat command line (mandatory)
- `options` extra options added to the socat command line (optional)
- `log` true/false if to log the socat stdout/stderr to data_path/socat.log (default: false)

**NOTE:** You'll have to change both the `master` and the `slave` options according to your needs. The defaults values will make sure that socat listens on port `8485` and redirects its output to `/dev/ttyZ2M`. The zigbee2mqtt's serial port setting is NOT automatically set and has to be changed accordingly.
