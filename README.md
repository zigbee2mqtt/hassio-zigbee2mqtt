![alt text][logo]
# Home Assistant Add-on: Zigbee2mqtt
Run [Zigbee2mqtt] as a Home Assistant Add-on

## Installation
Add the repository URL under **Supervisor → Add-on store → ⋮ → Manage add-on repositories**:

    https://github.com/zigbee2mqtt/hassio-zigbee2mqtt

The repository includes two add-ons:

- **zigbee2mqtt** is a stable release that tracks the released versions of zigbee2mqtt.
- **zigbee2mqtt-edge** tracks the `dev` branch of zigbee2mqtt, so you can install the edge version if there are features or fixes in the dev branch that are not yet released.

For more information see [the documentation](https://github.com/zigbee2mqtt/hassio-zigbee2mqtt/blob/master/zigbee2mqtt/DOCS.md).

# Changelog
The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/).

All notable changes to this project will be documented in the [CHANGELOG.md](zigbee2mqtt/CHANGELOG.md) file.

Version for releases is based on [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt) format: `X.Y.Z`.

Any changes on the addon that do not require a new version of [zigbee2mqtt] will use the format: `X.Y.Z-A` where `X.Y.Z` is fixed on the zigbee2mqtt release version and `A` is related to the addon.

Edge version will not maintain a CHANGELOG and doesn't have a version.

# Issues
If you find any issues with the add-on, please check the [issue tracker](https://github.com/danielwelch/hassio-zigbee2mqtt/issues) for similar issues before creating one. If your issue is regarding specific devices or, more generally, an issue that arises after zigbee2mqtt has successfully started, it should likely be reported in the [zigbee2mqtt issue tracker](https://github.com/Koenkk/zigbee2mqtt/issues).

Feel free to create a PR for fixes and enhancements. 

# Credits
- [danielwelch](https://github.com/danielwelch)
- [ciotlosm](https://github.com/ciotlosm)
- [Koenkk](https://github.com/Koenkk) for [zigbee2mqtt]

[logo]: zigbee2mqtt/logo.png "Zigbee2mqtt"
[zigbee2mqtt]: https://www.zigbee2mqtt.io