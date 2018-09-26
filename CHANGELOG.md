# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/).

This project is versioned based upon the version of [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt). The versioning `X.Y.Z` of the stable release of this add-on will track that of zigbee2mqtt. If there are new releases without upgrades to the zigbee2mqtt version (i.e., changes to the add-on that occur between releases of zigbee2mqtt), an additional number will be added to indicate this (`X.Y.Z.A`, where `A` indicates a new versioned release).

## [0.1.6](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v0.1.6) - 2018-09-26
### Changed
- update zigbee2mqtt to version 0.1.6

## [0.1.5.1](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v0.1.5.1) - 2018-09-24
### Changed
- Fixed bugs related to #53 and #54, regarding `log_directory` setting
- Fixed README typo regarding `disable_led`. This option is now called `disable_led` in accordance with zigbe22mqtt. Although this was changed in 0.1.3.1, README was not updated to reflect that.

## [0.1.5](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v0.1.5) - 2018-09-17
### Changed
- update zigbee2mqtt to version 0.1.5

## [0.1.3.1](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v0.1.3.1) - 2018-09-17
### Changed
- Includes new or changed options for zigbee2mqtt:
    - `mqtt_client_id`
    - `disable_led` (*renamed from `serial_disable_led`*)
    - `cache_state`
    - `log_directory`
    - `log_level`
    - `rtscts`
    - `zigbee_shepherd_debug`


## [0.1.3](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v0.1.3) - 2018-07-31
### Changed
- Upgrade to version 0.1.3 of `zigbee2mqtt`

## [0.1.2](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v0.1.2) - 2018-07-31
### Changed
- Upgrade to version 0.1.2 of `zigbee2mqtt`

## [0.1.1](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v0.1.1) - 2018-07-29
### Changed
- Switch the edge and non-edge dockerfiles so they're actually correct. Sigh. This is why you don't write code after 28 hour shifts.
- Download release archives instead of git cloning the specific branch
- Upgrade to version 0.1.1 of `zigbee2mqtt`

## [0.1.0](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v0.1.0) - 2018-07-16
### Changed
Version 0.1.0 is the first versioned release of the add-on. The repository actually establishes two add-ons:
- `zigbee2mqtt` add-on, which will use the first released version of the `zigbee2mqtt` library and will update as new versions of that library are released
- `zigbee2mqtt-edge` add-on, which will build with the latest commit to the `zigbee2mqtt` master branch. Each update to the library will trigger a new add-on image to be built. In effect, this add-on will function the same way that the pre-release version of this add-on did.
