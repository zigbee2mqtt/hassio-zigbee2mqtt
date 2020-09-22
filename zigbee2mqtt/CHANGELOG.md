## 1.14.4.2 - 2020-09-19
### Added
- Readme for *edge* version
- Logo on both *edge* and **stable** version
- Documentation tab for **stable** version
### Changed
- Startup for addon moved from `before` to `application`
### Fixed
- Empty changelog in *edge* version
- Addon crash for starting too early for some users
- `.hash.json` now properly generated (`commit #unknown` resolved)

## 1.14.4.1 - 2020-09-17
### :warning: Breaking changes
- Several options changed
    - `availability_blacklist` renamed to `availability_blocklist` in `advanced`
    - `availability_passlist` now required option in `advanced`
    - `ban` renamed to `blocklist`
    - `whitelist` renamed to `passlist`

:warning: If add-on fails to start :warning:

Change
```
availability_blacklist: []
```
to
```
availability_blocklist: []
availability_passlist: []
```

Remove 
```
ban: []
whitelist: []
```

### Added
- Explicit support for `armv7`
- Includes new config options from zigbee2mqtt:
    - `external_converters`
    - `mqtt`
        - `keepalive`
        - `version`
    - `advanced`
        - `adapter_concurrent`
        - `cache_state_persistent`
        - `cache_state_send_on_startup`
        - `device_options`
            - `occupancy_timeout`
            - `temperature_precision`
            - `legacy`
        - `device_options_string`
        - `homeassistant_legacy_triggers`
        - `log_level`
        - `log_rotation`
        - `timestamp_format`
    - `experimental`
        - `output`

### Fixed
- CHANGELOG bug for **stable** version
### Changed
- Updated names to reflect Hass.io [rename](https://www.home-assistant.io/blog/2020/01/29/changing-the-home-assistant-brand/) to Home Assistant
- Cleanup documentation

## 1.14.4 - 2020-09-02
### Changed
- Updated to latest Zigbee2Mqtt version [`1.14.4`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.4)


## 1.14.3 - 2020-08-12
### Added
- Includes new config options from zigbee2mqtt:
    - `serial`
        - `adapter`

### Changed
- Updated to latest Zigbee2Mqtt version [`1.14.3`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.3)

## 1.14.2 - 2020-07-22
### Changed
- Updated to latest Zigbee2Mqtt version [`1.14.2`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.2)
- Note: Configuration options need to be upgrade manually: Prefer blocklist/passlist terminology over blacklist/whitelist

## 1.14.1 - 2020-06-30
### Changed
- Updated to latest Zigbee2Mqtt version [`1.14.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.1)

## 1.14.0 - 2020-06-10
### Changed
- Updated to latest Zigbee2Mqtt version [`1.14.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.0)

## 1.13.1 - 2020-05-23
### Added
- Added config option `transmit_power` under the new `experimental category`
### Changed
- Updated to latest Zigbee2Mqtt version [`1.13.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.13.1)

## 1.13.0 - 2020-04-29
### Changed
- Updated to latest Zigbee2Mqtt version [`1.13.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.13.0)

## 1.12.2 - 2020-04-09
### Changed
- Updated to latest Zigbee2Mqtt version [`1.12.2`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.12.2)

## 1.12.1 - 2020-04-08
### Changed
- Updated to latest Zigbee2Mqtt version [`1.12.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.12.1)

## 1.12.0 - 2020-03-18
### Changed
- Updated to latest Zigbee2Mqtt version [`1.12.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.12.0)

## 1.11.0 - 2020-02-26
### Changed
- Updated to latest Zigbee2Mqtt version [`1.11.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.11.0)

## 1.10.1 - 2020-02-12
### Added
- Added config options `network_key_string` and `ext_pan_id_string`.

## 1.10.0 - 2019-02-06
### Changed
- Upgrade zigbe22mqtt to 1.10.0

## 1.9.0 - 2019-01-17
### Added
- Added config option `zigbee_herdsman_debug`. Zigbee2mqtt moved from the old `zigbee_shepherd` library to the `zigbee_herdsman` library some time ago, so this option was added to reflect the change and keep things consistent. The old `zigbee_shepherd_debug` option is still supported, and setting either to `true` will enable `zigbee_shepherd` DEBUG mode.
### Changed
- Upgrade zigbee2mqtt to 1.9.0

## 1.8.0 - 2019-12-16
### Changed
- Upgrade zigbee2mqtt to 1.8.0

## 1.7.1 - 2019-11-12
### Changed
- Upgrade zigbee2mqtt to 1.7.1

## 1.7.0 - 2019-11-10
### Added
- BREAKING: socat support added (new top level option in configuration)
### Changed
  - Disabled by default -- leave `enabled` set to false to disable.
- BREAKING:
- Upgrade zigbee2mqtt to 1.7.0
  - There are breaking changes when upgrading to zigbee2mqtt 1.7 with respect to the user's underlying zigbee device database used by zigbee2mqtt. You cannot roll back to 1.6 after updating without repairing all your devices (the device database used by zigbee2mqtt 1.7 is not backwards compatible for older versions)

## 1.6.0 - 2019-09-11
### Changed
- Upgrade zigbee2mqtt to 1.6.0

## [1.5.1.2](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v1.5.1.2) - 2019-07-30
### Added
### Fixed
- Create `$DATA_PATH` if it does not already exist
- Fix default configuration typo (#197)

## [1.5.1.1](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v1.5.1.1) - 2019-07-22
### Added
- Adds several configuration items:
    - `advanced.availability_blacklist`
    - `ban`
    - `whitelist`
    - `queue` (along with `queue.delay` and `queue.simultaneously`)
    - `mqtt.key`, `mqtt.ca`, `mqtt.cert`
    - `advanced.report`, `advanced.homeassistant_discovery_topic`, `advanced.homeassistant_status_topic`
### Fixed
- Add back `zigbee_shepherd_debug`,`zigbee_shepherd_devices`, and `disable_led`
- Include default network key in default configuration, as this is used by zigbee2mqtt by default.

## [1.5.1](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v1.5.1) - 2019-07-20
### Changed
- BREAKING CHANGE: restructured configuration to more closely mirror zigbee2mqtt
- upgrade zigbee2mqtt to 1.5.1

## [1.3.0](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v1.3.0) - 2019-04-08
### Changed
- Update zigbee2mqtt to version 1.3.0
### Added
- Includes new config option from zigbee2mqtt:
    - `homeassistant_discovery_topic`
    - `debounce` (device-specific config)
### Fixed
- Fixes logic bug that prevented configuration from being updated via the Home Assistant frontend UI.

## [1.2.1](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v1.2.1) - 2019-03-10
### Changed
- Update zigbee2mqtt to version 1.2.1
- Use Node.js 10 as base docker image
### Added
- Includes new config option from zigbee2mqtt:
    - `report`

## [1.1.1](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v1.1.1) - 2019-02-02
### Changed
- Update zigbee2mqtt to version 1.1.1

## [1.0.1.1](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v1.1.0) - 2019-01-30
### Changed
- Add `network_key` to options, defaulting to empty list. If left empty, the option will not be passed to zigbee2mqtt.
- Update README to reflect requirements for `devices` and `network_key` options

## [1.0.1](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v1.1.0) - 2019-01-30
### Changed
- update zigbee2mqtt to version 1.1.0
### Added
- Includes new config options from zigbee2mqtt:
    - `soft_reset_timeout`
    - `last_seen`
    - `elapsed`
    - `network_key`
    - `devices` (device-specific configuration)
- Includes `overwrite` option, which can be set to `false` to prevent the add-on from overwriting corresponding fields on startup that are already set in the `configuration.yaml` file.

## [1.0.1](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v1.0.1) - 2018-12-17
### Changed
- update zigbee2mqtt to version 1.0.1

## [1.0.0](https://github.com/danielwelch/hassio-zigbee2mqtt/releases/tag/v1.0.0) - 2018-12-17
### Changed
- update zigbee2mqtt to version 1.0.0
### Added
- Includes new or changed options for zigbee2mqtt:
    - `reject_unauthorized`
    - `pan_id`
    - `channel`

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
### Added
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
