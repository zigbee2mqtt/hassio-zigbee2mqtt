# Pairing

By default the add-on has `permit_join` set to `false`. To allow devices to join you need to activate this after the add-on has started. You can now use the [built-in frontend](https://www.zigbee2mqtt.io/information/frontend.html) to achieve this. For details on how to enable the built-in frontent see the next section.

# Enabling the built-in frontend

Enable `ingress` to have the frontend available in your UI: **Settings → Add-ons → Zigbee2MQTT → Show in sidebar**. You can find more details about the feature on the [Zigbee2MQTT documentation](https://www.zigbee2mqtt.io/information/frontend.html).

# Configuration

## Onboarding

[Onboarding](https://www.zigbee2mqtt.io/guide/getting-started/#onboarding) allows you to setup Zigbee2MQTT without having to manually enter the details in the add-on configuration page. When starting the add-on with a brand new install (no configuration present), the frontend will show a quick setup page, allowing you to select various settings for Zigbee2MQTT to be able to start.

> [!NOTE]
> Successful detection of adapters, to select from, may vary based on your setup/network. You may have to enter these [details manually](https://www.zigbee2mqtt.io/guide/configuration/adapter-settings.html#basic-configuration) on the page instead.

> [!TIP]
> You can force the onboarding to re-run (e.g. changing adapter) using the toggle available in the add-on configuration page (visible after checking `Show unused optional configuration options`). This will force onboarding to run even after you have successfully configured it for the first time. Make sure to disable it once done.

## Manual

Configuration required to startup Zigbee2MQTT is available from the add-on configuration. The rest of the options can be configured via the Zigbee2MQTT frontend.

> [!CAUTION]
> Settings configured through the add-on configuration page will take precedence over settings in the `configuration.yaml` page (e.g. you set `rtscts: false` in add-on configuration page and `rtscts: true` in `configuration.yaml`, `rtscts: false` will be used). _If you want to control the entire configuration through YAML, remove them from the add-on configuration page._

#### Examples for each configuration section

- socat
  ```yaml
  enabled: false
  master: pty,raw,echo=0,link=/tmp/ttyZ2M,mode=777
  slave: tcp-listen:8485,keepalive,nodelay,reuseaddr,keepidle=1,keepintvl=1,keepcnt=5
  options: "-d -d"
  log: false
  ```
- mqtt
  ```yaml
  server: mqtt://localhost:1883
  user: my_user
  password: "my_password"
  ```
- serial
  ```yaml
  adapter: zstack
  port: /dev/serial/by-id/usb-Texas_Instruments_TI_CC2531_USB_CDC___0X00124B0018ED3DDF-if00
  ```

# Configuration backup

The add-on will create a backup of your configuration.yml within your data path: `$DATA_PATH/configuration.yaml.bk`. When upgrading, you should use this to fill in the relevant values into your new config, particularly the network key, to avoid breaking your network and having to re-pair all of your devices.
The backup of your configuration is created on add-on startup if no previous backup was found.

# Enabling the watchdog

To automatically restart Zigbee2MQTT in case of a soft failure (like "adapter disconnected"), the watchdog can be used. It can be enabled by adding the following to the add-on configuration:

```yaml
watchdog: default
```

This will use the default watchdog retry delays of 1min, 5min, 15min, 30min, 60min. Custom delays are also supported, e.g. `watchdog: 5,10,30` will start Zigbee2MQTT with the watchdog's retry delays of 5min, 10min, 30min. For more information about the watchdog, read the [docs](https://www.zigbee2mqtt.io/guide/installation/15_watchdog.html).

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
