## 1.14.4.2 - 2020-09-19
- Added readme for *edge* version
- Added logo on both *edge* and **stable** version
- Added documentation tab for **stable** version
- Startup for addon moved from `before` to `application`
- Fixed empty changelog in *edge* version
- Fixed add-on crash for starting too early for some users
- Fixed `.hash.json` to get properly generated (`commit #unknown` resolved)

## 1.14.4.1 - 2020-09-17
- ⚠️ **Breaking change**
    - `availability_blacklist` renamed to `availability_blocklist` in `advanced`
    - `availability_passlist` now required option in `advanced`
    - `ban` renamed to `blocklist`
    - `whitelist` renamed to `passlist`

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

- Added explicit support for `armv7`
- Added new config options from Zigbee2mqtt:
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

- Fixed change log bug for **stable** version
- Updated names to reflect Hass.io [rename](https://www.home-assistant.io/blog/2020/01/29/changing-the-home-assistant-brand/) to Home Assistant
- Cleanup documentation

## 1.14.4 - 2020-09-02
- Updated Zigbee2mqtt to version [`1.14.4`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.4)


## 1.14.3 - 2020-08-12
- Added new config options from zigbee2mqtt:
    - `serial`
        - `adapter`
- Updated Zigbee2mqtt to version [`1.14.3`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.3)

## 1.14.2 - 2020-07-22
- Updated Zigbee2mqtt to version [`1.14.2`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.2)
- ⚠️ Configuration options need to be updated manually: Prefer blocklist/passlist terminology over blacklist/whitelist

## 1.14.1 - 2020-06-30
- Updated Zigbee2mqtt to version [`1.14.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.1)

## 1.14.0 - 2020-06-10
- Updated Zigbee2mqtt to version [`1.14.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.0)

## 1.13.1 - 2020-05-23
- Added config option `transmit_power` under the new `experimental category`
- Updated Zigbee2mqtt to version [`1.13.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.13.1)

## 1.13.0 - 2020-04-29
- Updated Zigbee2mqtt to version [`1.13.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.13.0)

## 1.12.2 - 2020-04-09
- Updated Zigbee2mqtt to version [`1.12.2`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.12.2)

## 1.12.1 - 2020-04-08
- Updated Zigbee2mqtt to version [`1.12.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.12.1)

## 1.12.0 - 2020-03-18
- Updated Zigbee2mqtt to version [`1.12.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.12.0)

## 1.11.0 - 2020-02-26
- Updated Zigbee2mqtt to version [`1.11.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.11.0)

## 1.10.1 - 2020-02-12
- Added config options `network_key_string` and `ext_pan_id_string`.

## 1.10.0 - 2019-02-06
- Updated Zigbee2mqtt to version [`1.10.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.10.0)

## 1.9.0 - 2019-01-17
- Added config option `zigbee_herdsman_debug` (`zigbee_shepherd_debug` still supported for now)
- Updated Zigbee2mqtt to version [`1.9.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.9.0)

## 1.8.0 - 2019-12-16
- Updated Zigbee2mqtt to version [`1.8.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.8.0)

## 1.7.1 - 2019-11-12
- Updated Zigbee2mqtt to version [`1.7.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.7.1)

## 1.7.0 - 2019-11-10
- ⚠️ **Breaking change**: You cannot roll back to 1.6 without repairing all your devices
- ⚠️ Added socat support: leave `enabled` set to `false` to disable.
- Updated Zigbee2mqtt to version [`1.7.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.7.0)

## 1.6.0 - 2019-09-11
- Update zigbee2mqtt to [`1.6.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.6.0)

## 1.5.1.2 - 2019-07-30
- Create `$DATA_PATH` if it does not already exist
- Fixed default configuration typo (#197)

## 1.5.1.1 - 2019-07-22
- Added several configuration items:
    - `advanced.availability_blacklist`
    - `ban`
    - `whitelist`
    - `queue` (along with `queue.delay` and `queue.simultaneously`)
    - `mqtt.key`, `mqtt.ca`, `mqtt.cert`
    - `advanced.report`, `advanced.homeassistant_discovery_topic`, `advanced.homeassistant_status_topic`
- Add back `zigbee_shepherd_debug`,`zigbee_shepherd_devices`, and `disable_led`
- Include default network key in default configuration, as this is used by zigbee2mqtt by default.

## 1.5.1 - 2019-07-20
- ⚠️ **Breaking change**: restructured configuration to more closely mirror zigbee2mqtt
- Updated Zigbee2mqtt to version [`1.5.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.5.1)

## 1.3.0 - 2019-04-08
- Updated Zigbee2mqtt to version [`1.3.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.3.0)
- Added new config option from zigbee2mqtt:
    - `homeassistant_discovery_topic`
    - `debounce` (device-specific config)
- Fixed logic bug that prevented configuration from being updated via the Home Assistant frontend UI.

## 1.2.1 - 2019-03-10
- Updated Zigbee2mqtt to version [`1.2.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.2.1)
- Use Node.js 10 as base docker image
- Added new config option from zigbee2mqtt: `report`

## 1.1.1 - 2019-02-02
- Updated Zigbee2mqtt to version [`1.1.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.1.1)

## 1.1.0.1 - 2019-01-30
- Added `network_key` to options, defaulting to empty list. If left empty, the option will not be passed to zigbee2mqtt.
- Update README to reflect requirements for `devices` and `network_key` options

## 1.1.0 - 2019-01-30
- Updated Zigbee2mqtt to version [`1.0.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.1.0)
- Added new config options from zigbee2mqtt:
    - `soft_reset_timeout`
    - `last_seen`
    - `elapsed`
    - `network_key`
    - `devices` (device-specific configuration)
- Added `overwrite` option, which can be set to `false` to prevent the add-on from overwriting corresponding fields on startup that are already set in the `configuration.yaml` file.

## 1.0.1 - 2018-12-17
- Updated Zigbee2mqtt to version [`1.0.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.0.1)

## 1.0.0 - 2018-12-17
- Updated Zigbee2mqtt to version [`1.0.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.0.0)
- Added new or changed options for zigbee2mqtt:
    - `reject_unauthorized`
    - `pan_id`
    - `channel`

## 0.1.6 - 2018-09-26
- Updated Zigbee2mqtt to version [`0.1.6`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/0.1.6)

## 0.1.5.1 - 2018-09-24
- Fixed bugs related to #53 and #54, regarding `log_directory` setting
- Fixed README typo regarding `disable_led`. This option is now called `disable_led` in accordance with zigbe22mqtt. Although this was changed in 0.1.3.1, README was not updated to reflect that.

## 0.1.5 - 2018-09-17
- Updated Zigbee2mqtt to version [`0.1.5`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/0.1.5)

## 0.1.3.1 - 2018-09-17
- Added new or changed options for zigbee2mqtt:
    - `mqtt_client_id`
    - `disable_led` (*renamed from `serial_disable_led`*)
    - `cache_state`
    - `log_directory`
    - `log_level`
    - `rtscts`
    - `zigbee_shepherd_debug`


## 0.1.3 - 2018-07-31
- Updated Zigbee2mqtt to version [`0.1.3`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/0.1.3)

## 0.1.2 - 2018-07-31
- Updated Zigbee2mqtt to version [`0.1.2`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/0.1.2)

## 0.1.1 - 2018-07-29
- Switch the edge and non-edge dockerfiles so they're actually correct. Sigh. This is why you don't write code after 28 hour shifts.
- Download release archives instead of git cloning the specific branch
- Updated Zigbee2mqtt to version [`0.1.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/0.1.1)

## 0.1.0 - 2018-07-16
- First versioned release of the add-on
- Updated Zigbee2mqtt to version [`0.1.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/0.1.0)
