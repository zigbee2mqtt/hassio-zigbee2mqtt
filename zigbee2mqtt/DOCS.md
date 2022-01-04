# Pairing
By default the add-on has `permit_join` set to `false`. To allow devices to join you need to activate this after the add-on has started. You can now use the [built-in frontend](https://www.zigbee2mqtt.io/information/frontend.html) to achieve this. For details on how to enable the built-in frontent see the next section.

# Enabling the built-in Frontend
Enable `ingress` to have the frontend available in your UI: **Supervisor → Dashboard → Zigbee2mqtt → Show in sidebar**. You can find more details about the feature on the [Zigbee2mqtt documentation](https://www.zigbee2mqtt.io/information/frontend.html).

# Configuration
See the [zigbee2mqtt configuration docs](https://www.zigbee2mqtt.io/information/configuration.html) for a complete description of available options. If you're not sure if a new option is supported, check to see if it is included in this add-on's default configuration. If not, you can open an issue to add support for it.

# Enabling zigbee debug mode
If you want to troubleshoot in more depth problems with your zigbee devics, sometimes you must enable DEBUG option on Zigbee2mqtt startup. To do this you must set `zigbee_herdsman_debug` to `true`.

```yaml
zigbee_herdsman_debug: true
```


# Adding Support for New Devices
If you are interested in [adding support for new devices to zigbee2mqtt](https://www.zigbee2mqtt.io/how_tos/how_to_support_new_devices.html) see methods below

### Using external_converters

Using `external_converters` option you will have more flexibility to add support but also allow you to maintain a DIY device support. Follow the [documentation](https://www.zigbee2mqtt.io/information/configuration.html#external-converters-configuration) to get started.

Examples: https://github.com/Koenkk/zigbee2mqtt.io/tree/master/docs/externalConvertersExample

# Notes
- Depending on your configuration, the MQTT server config may need to include the port, typically `1883` or `8883` for SSL communications. For example, `mqtt://core-mosquitto:1883` for Home Assistant's Mosquitto add-on.
- To find out which serial ports you have exposed go to **Supervisor → System → Host system → ⋮ → Hardware**
- Please see this add-on's [documentation on GitHub](https://github.com/zigbee2mqtt/hassio-zigbee2mqtt/blob/dev/zigbee2mqtt/DOCS.md#socat) for further add-on-specific information (using Socat, how to add support for new devices etc.).
- The 'devices' and 'groups' configuration options accept arrays of files since Zigbee2MQTT v1.16.2. In order to maintain backwards compatibility of configurations, the same functionality is achieved in this addon by the use of comma-separated strings.
- If you want to use [Zigbee2mqtt scripts](https://github.com/Koenkk/zigbee2mqtt/tree/master/scripts) for example to clear NVMEM after usb firmware update, execute the following within the docker container: first: `killall node` second: `node /app/scripts/zStackEraseAllNvMem.js /dev/ttyUSB0`

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
