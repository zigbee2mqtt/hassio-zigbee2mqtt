## 1.21.0-1
- Updated Zigbee2MQTT to version [`1.21.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.21.0)

## 1.20.0-1
- Updated Zigbee2MQTT to version [`1.20.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.20.0)

## 1.19.1-1
- Updated Zigbee2MQTT to version [`1.19.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.19.1)

## 1.19.0-1
- Updated Zigbee2MQTT to version [`1.19.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.19.0)

## 1.18.3-1
- Updated Zigbee2MQTT to version [`1.18.3`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.18.3)

## 1.18.2-1
- Updated Zigbee2MQTT to version [`1.18.2`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.18.2)

## 1.18.1-2
- Added missing ezsp agapter type for serial

## 1.18.1-1
- Updated Zigbee2mqtt to version [`1.18.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.18.1)
- Fix OTA configuration required when starting

## 1.18.0-1
- Updated Zigbee2mqtt to version [`1.18.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.18.0)

## 1.17.1-4
- Switched socat from `/share/zigbee2mqtt/ttyZ2M` to `/tmp/ttyZ2M`

## 1.17.1-3
- Added back `transmit_power` to `experimental`

## 1.17.1-2
- Fixes #24 for socat

## 1.17.1-1
- Removed `new_api` option as it's now default
- Removed `transmit_power` from `experimental`
- Added support for `legacy_api` option under `advanced`
- Added support for `ikea_ota_use_test_url` option under `advanced`

## 1.17.1
- Updated Zigbee2mqtt to version [`1.17.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.17.1)
- Updated `"auto_uart": true` to use `"uart": true` instead
- Reduced image size - thanks https://github.com/G1K
- Deprecated `devices.js` method for adding support for a new device

## 1.17.0
- Updated Zigbee2mqtt to version [`1.17.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.17.0)
- New configuration options
     - `advanced`
         - `adapter_delay`
     - `serial`
         - `adapter: zigate`
## 1.16.2
- Updated Zigbee2mqtt to version [`1.16.2`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.16.2)
- New configuration options
    - `mqtt`
        - `force_disable_retain`
    - `frontend`
        - `host`
- `devices` and `groups` options now accept a comma-separated string of files

## 1.16.1-1
- Allow add-on to start with other mqtt servers not just built in

## 1.16.1
- Updated Zigbee2mqtt to version [`1.16.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.16.1)

## 1.16.0
- Updated Zigbee2mqtt to version [`1.16.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.16.0)

## 1.15.0-3
- Fixed `external_converters` not working

## 1.15.0-2
- ⚠️ **Breaking changes**
  - `zigbee_shepherd_debug` removed
- Add-on images are now taken from Docker Hub `zigbee2mqtt` [organisation](https://hub.docker.com/orgs/zigbee2mqtt/repositories)
- Changed `mqtt.server`, `mqtt.user`, `mqtt.password` to be optional
- Added support for mqtt auto discovery (server, user, password)
- Removed `pm2`
- Removed `socat.restartdelay` and `socat.initialdelay`
- Unified Dockerfile into a single common file
- ⚠️ Changed `run.sh` and `socat.sh` to use [s6-overlay](https://github.com/just-containers/s6-overlay)
- Version management now only in `config.json`
- Default `data_path` changed from `/share/` to `/config`
- Changed default logging level to `warn`
- Changed version format to `X.X.X-A`

## 1.15.0
- Updated Zigbee2mqtt to version [`1.15.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.15.0)
- Added support for a [built-in frontend](https://github.com/Koenkk/zigbee2mqtt/issues/4266) using `ingress`. See Documentation tab for more details.

## 1.14.4.2
- Added readme for Edge version
- Added logo on both Edge and Stable version
- Startup for addon moved from `before` to `application`
- Fixed empty changelog in Edge version
- Fixed add-on crash for starting too early for some users
- Fixed `.hash.json` to get properly generated (`commit #unknown` resolved)

## 1.14.4.1
- ⚠️ **Breaking changes**
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

- Fixed change log bug for Stable version
- Updated names to reflect Hass.io [rename](https://www.home-assistant.io/blog/2020/01/29/changing-the-home-assistant-brand/) to Home Assistant

## 1.14.4
- Updated Zigbee2mqtt to version [`1.14.4`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.4)

## 1.14.3
- Added new config option from Zigbee2mqtt: `adapter` in `serial`
- Updated Zigbee2mqtt to version [`1.14.3`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.3)

## 1.14.2
- Updated Zigbee2mqtt to version [`1.14.2`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.2)

## 1.14.1
- Updated Zigbee2mqtt to version [`1.14.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.1)

## 1.14.0
- Updated Zigbee2mqtt to version [`1.14.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.14.0)

## 1.13.1
- Added config option `transmit_power` in `experimental`
- Updated Zigbee2mqtt to version [`1.13.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.13.1)

## 1.13.0
- Updated Zigbee2mqtt to version [`1.13.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.13.0)

## 1.12.2
- Updated Zigbee2mqtt to version [`1.12.2`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.12.2)

## 1.12.1
- Updated Zigbee2mqtt to version [`1.12.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.12.1)

## 1.12.0
- Updated Zigbee2mqtt to version [`1.12.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.12.0)

## 1.11.0
- Updated Zigbee2mqtt to version [`1.11.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.11.0)

## 1.10.1
- Added config options `network_key_string` and `ext_pan_id_string`.

## 1.10.0
- Updated Zigbee2mqtt to version [`1.10.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.10.0)

## 1.9.0
- Added config option `zigbee_herdsman_debug` (`zigbee_shepherd_debug` still supported for now)
- Updated Zigbee2mqtt to version [`1.9.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.9.0)

## 1.8.0
- Updated Zigbee2mqtt to version [`1.8.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.8.0)

## 1.7.1
- Updated Zigbee2mqtt to version [`1.7.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.7.1)

## 1.7.0
- ⚠️ **Breaking changes**: You cannot roll back to 1.6 without repairing all your devices
- ⚠️ Added socat support: leave `enabled` set to `false` to disable.
- Updated Zigbee2mqtt to version [`1.7.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.7.0)

## 1.6.0
- Update Zigbee2mqtt to [`1.6.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.6.0)

## 1.5.1.2
- Create `$DATA_PATH` if it does not already exist
- Fixed [#197](https://github.com/danielwelch/hassio-zigbee2mqtt/issues/197)

## 1.5.1.1
- Added several configuration items:
    - `advanced.availability_blacklist`
    - `ban`
    - `whitelist`
    - `queue` (along with `queue.delay` and `queue.simultaneously`)
    - `mqtt.key`, `mqtt.ca`, `mqtt.cert`
    - `advanced.report`, `advanced.homeassistant_discovery_topic`, `advanced.homeassistant_status_topic`
- Add back `zigbee_shepherd_debug`,`zigbee_shepherd_devices`, and `disable_led`
- Include default network key in default configuration

## 1.5.1
- ⚠️ **Breaking changes**: restructured configuration to more closely mirror Zigbee2mqtt
- Updated Zigbee2mqtt to version [`1.5.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.5.1)

## 1.3.0
- Updated Zigbee2mqtt to version [`1.3.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.3.0)
- Added new config option from zigbee2mqtt:
    - `homeassistant_discovery_topic`
    - `debounce` (device-specific config)
- Fixed logic bug that prevented configuration from being updated in the add-on ui.

## 1.2.1
- Updated Zigbee2mqtt to version [`1.2.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.2.1)
- Use Node.js 10 as base docker image
- Added new config option from Zigbee2mqtt: `report`

## 1.1.1
- Updated Zigbee2mqtt to version [`1.1.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.1.1)

## 1.1.0.1
- Added `network_key` to options, defaulting to empty list. If left empty, the option will not be passed to zigbee2mqtt.
- Update README to reflect requirements for `devices` and `network_key` options

## 1.1.0
- Updated Zigbee2mqtt to version [`1.0.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.1.0)
- Added new config options from Zigbee2mqtt:
    - `soft_reset_timeout`
    - `last_seen`
    - `elapsed`
    - `network_key`
    - `devices` (device-specific configuration)
- Added `overwrite` option, which can be set to `false` to prevent the add-on from overwriting corresponding fields on startup that are already set in the `configuration.yaml` file.

## 1.0.1
- Updated Zigbee2mqtt to version [`1.0.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.0.1)

## 1.0.0
- Updated Zigbee2mqtt to version [`1.0.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/1.0.0)
- Added new or changed options for Zigbee2mqtt:
    - `reject_unauthorized`
    - `pan_id`
    - `channel`

## 0.1.6
- Updated Zigbee2mqtt to version [`0.1.6`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/0.1.6)

## 0.1.5.1
- Fixed [#53](https://github.com/danielwelch/hassio-zigbee2mqtt/issues/53) and [#54](https://github.com/danielwelch/hassio-zigbee2mqtt/issues/54), regarding `log_directory` setting
- Fixed README typo regarding `disable_led`. This option is now called `disable_led` in accordance with zigbe22mqtt. Although this was changed in 0.1.3.1, README was not updated to reflect that.

## 0.1.5
- Updated Zigbee2mqtt to version [`0.1.5`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/0.1.5)

## 0.1.3.1
- Added new or changed options for Zigbee2mqtt:
    - `mqtt_client_id`
    - `disable_led` (*renamed from `serial_disable_led`*)
    - `cache_state`
    - `log_directory`
    - `log_level`
    - `rtscts`
    - `zigbee_shepherd_debug`

## 0.1.3
- Updated Zigbee2mqtt to version [`0.1.3`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/0.1.3)

## 0.1.2
- Updated Zigbee2mqtt to version [`0.1.2`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/0.1.2)

## 0.1.1
- Switch the Edge and Stable `Dockerfiles` so they're actually correct
- Download release archives instead of git cloning the specific branch
- Updated Zigbee2mqtt to version [`0.1.1`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/0.1.1)

## 0.1.0
- First versioned release of the add-on
- Updated Zigbee2mqtt to version [`0.1.0`](https://github.com/Koenkk/zigbee2mqtt/releases/tag/0.1.0)
