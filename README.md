<div align="center">
<img src="images/logo.png">
<h1>Home Assistant Add-on: Zigbee2mqtt</h1>
<div style="display: flex; justify-content: center;">
  <a style="margin-right: 0.5rem;" href="https://dev.azure.com/danielwelch2101/hassio-zigbee2mqtt/_build?definitionId=1&_a=summary">
    <img src="https://img.shields.io/azure-devops/build/danielwelch2101/fdcd83e4-a36e-473f-80f8-6a1bd49fdb3a/1?label=build&logo=azure-pipelines&style=flat-square">
  </a>
  <a style="margin-left: 0.5rem;" href="https://cloud.docker.com/u/dwelch2101/repository/docker/dwelch2101/zigbee2mqtt-armhf">
    <img src="https://img.shields.io/docker/pulls/dwelch2101/zigbee2mqtt-armhf.svg?style=flat-square&logo=docker">
  </a>
</div>
<br>
<p>Run <a href="https://www.zigbee2mqtt.io">Zigbee2mqtt</a> as a Home Assistant Add-on</p>
</div>

## Installation

Add the repository URL under **Supervisor → Add-on store → ⋮ → Manage add-on repositories**:

    https://github.com/danielwelch/hassio-zigbee2mqtt

The repository includes two add-ons:

- **zigbee2mqtt** is a stable release that tracks the released versions of zigbee2mqtt.
- **zigbee2mqtt-edge** tracks the `dev` branch of zigbee2mqtt, so you can install the edge version if there are features or fixes in the dev branch that are not yet released.

## Pairing

The suggested way to pair your devices is to enable zigbee2mqtt's `permit_join` option from within Home Assistant using MQTT rather than through the add-on's user interface.

You can use [Zigbee2MqttAssistant](https://github.com/yllibed/Zigbee2MqttAssistant) if you don't want to use MQTT directly.

### Updating the edge Add-on
To update the edge version of the add-on, you will need to uninstall and re-install the add-on. If you have reinstalled the add-on and believe that the latest version has not been installed, try removing the repository before reinstalling.

### Socat
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

### Adding Support for New Devices

If you are interested in [adding support for new devices to zigbee2mqtt](https://www.zigbee2mqtt.io/how_tos/how_to_support_new_devices.html), set the optional, top-level `zigbee_shepherd_devices` option to `true` in your configuration. When set, the add-on will scan your `data_path` for a `devices.js` file, and will run zigbee2mqtt using this custom file.

### Issues

If you find any issues with the add-on, please check the [issue tracker](https://github.com/danielwelch/hassio-zigbee2mqtt/issues) for similar issues before creating one. If your issue is regarding specific devices or, more generally, an issue that arises after zigbee2mqtt has successfully started, it should likely be reported in the [zigbee2mqtt issue tracker](https://github.com/Koenkk/zigbee2mqtt/issues).

Feel free to create a PR for fixes and enhancements. 

## Warning: Breaking Changes in version 1.7.0+

Once upgraded from 1.6.0 to 1.7.0 you cannot switch back to 1.6.0 when not having a backup of the database.db!

## Warning: Breaking Changes in version 1.5.1

Version 1.5.1 contains breaking changes and requires re-formating of the add-on configuration. Please see the updated configuration documentation below.

#### Restoring Configuration after upgrading to 1.5.1

By default, when upgrading to v1.5.1, the add-on will create a backup of your configuration.yml within your data path: `$DATA_PATH/configuration.yaml.bk`. When upgrading, you should use this to fill in the relevant values into your new config, particularly the network key, to avoid breaking your network and having to repair all of your devices.

## Credits
- [danielwelch](https://github.com/danielwelch)
- [ciotlosm](https://github.com/ciotlosm)
- [Koenkk](https://github.com/Koenkk) for [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt)
