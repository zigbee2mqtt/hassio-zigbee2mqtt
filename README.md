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

## Changelog
The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/).

All notable changes to this project will be documented in the [CHANGELOG.md](zigbee2mqtt/CHANGELOG.md) file.

Version for releases is based on [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt) format: `X.Y.Z`.

Any changes on the addon that do not require a new version of [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt) will use the format: `X.Y.Z.A` where `X.Y.Z` is fixed on the zigbee2mqtt release version and `A` is related to the addon.

Edge version will not maintain a CHANGELOG and doesn't have a version.

## Adding Support for New Devices
If you are interested in [adding support for new devices to zigbee2mqtt](https://www.zigbee2mqtt.io/how_tos/how_to_support_new_devices.html) you will need to use one of the methods below to allow you to change the required files.

### Using devices.js override in add-on

Set the optional, top-level `zigbee_shepherd_devices` option to `true` in your configuration. 

```
zigbee_shepherd_devices: true
```

When set, the add-on will scan your `data_path` for a `devices.js` file, and will run zigbee2mqtt using this custom file.

:warning: If you want to make sure that the version of `devices.js` fits your add-on, make sure to follow the steps below:

1. Identify your `stable` zigbee2mqtt version from the add-on (ex. `1.14.3`)
2. Navigate to https://github.com/Koenkk/zigbee2mqtt/tags and find tag (ex. `1.14.3`)
3. Click on the commit hash (ex. `f8066e8`) and then `browse files` button
4. Find `package.json` and identify `zigbee-herdsman-converters` version (ex. `12.0.161`)
5. Navigate to https://github.com/Koenkk/zigbee-herdsman-converters/tags and find tag (ex. `12.0.161`)
6. Click on the commit hash (ex. `3a5abc7`) and then `browse files` button
7. Find `devices.js` file and download it (use `raw` version)

### Using external_converters

Using `external_converters` option you will have more flexibility to add support but also allow you to maintain a DIY device support. Follow the [documentation](https://www.zigbee2mqtt.io/information/configuration.html#external-converters-configuration) to get started.

If you are searching to edit specific files, please find the Line reference in the example converter where to make your changes:

- `fromZigbee.js`: https://github.com/Koenkk/zigbee2mqtt.io/blob/master/docs/externalConvertersExample/dummy-converter.js#L15
- `homeassistant.js`: https://github.com/Koenkk/zigbee2mqtt.io/blob/master/docs/externalConvertersExample/dummy-converter.js#L66

## Issues

If you find any issues with the add-on, please check the [issue tracker](https://github.com/danielwelch/hassio-zigbee2mqtt/issues) for similar issues before creating one. If your issue is regarding specific devices or, more generally, an issue that arises after zigbee2mqtt has successfully started, it should likely be reported in the [zigbee2mqtt issue tracker](https://github.com/Koenkk/zigbee2mqtt/issues).

Feel free to create a PR for fixes and enhancements. 

## Credits
- [danielwelch](https://github.com/danielwelch)
- [ciotlosm](https://github.com/ciotlosm)
- [Koenkk](https://github.com/Koenkk) for [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt)
