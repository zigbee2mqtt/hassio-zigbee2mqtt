# Home Assistant Add-on: Zigbee2MQTT Devel

⚠️ This is the Devel version. It takes much longer to run than the other versions, because it reinstalls all the dependencies on each start, but you can configure a fork which you want to follow. It's mainly aimed for developers that want to test their changes without a need to have them merged into the main repository.⚠️

Allows you to use your Zigbee devices **without** the vendors bridge or gateway.

It bridges events and allows you to control your Zigbee devices via MQTT. In this way you can integrate your Zigbee devices with whatever smart home infrastructure you are using.

See Documentation tab for more details.

### Updating the Devel add-on
To update the `devel` version of the add-on, you will need to uninstall and re-install the add-on after you set up the fork url and the branch in the configuration options.

⚠️ Make sure to backup your config as the procedure will not save this for you.

**Steps**
1. Backup config from: **Settings → Add-ons → Zigbee2MQTT Devel → Configuration → ⋮ → Edit in YAML**, copy the **Options** somewhere safe
1. Uninstall: **Settings → Add-ons → Zigbee2MQTT Devel → Uninstall**
1. Refresh repo: **Settings → Add-ons → Add-ons store → ⋮ → Check for updates**
1. Install: **Settings → Add-ons → Add-ons store → Zigbee2MQTT Devel → Install**
1. Restore config to: **Settings → Add-ons → Zigbee2MQTT Devel → Configuration → ⋮ → Edit in YAML**, paste your config from step 1.
