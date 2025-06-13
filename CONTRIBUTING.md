# Setting up
1. Git clone this project into your add-ons folder
2. Remove the `image` key from `zigbee2mqtt-edge/config.json` to enable local builds.
3. Add back `"image": "zigbee2mqtt/zigbee2mqtt-edge-{arch}"` to `zigbee2mqtt-edge/config.json` after you're done.

# Upgrading the Zigbee2MQTT version
1. Change the version number in `zigbee2mqtt/config.json`: `"version": "$NEW_VERSION"`
2. Update `zigbee2mqtt/CHANGELOG.md`
3. Commit the changes to `master` branch
4. Wait till ci finishes
5. Publish a new "Release". Very important you specify Target: master. Example
```
Tag version: v1.25.2-1  @ Target: master
Release title: v1.25.2-1
```

# Developing against the Home Assistant container

When you want to check the impact of developing work, e.g. adjusting devices in [zigbee-herdsman-converters](https://github.com/Koenkk/zigbee-herdsman-converters), you need access to the add-on container in Home Assistant. Here's how:

🚨 Following these directions will make your Home Assistant system more prone to misconfiguration (by yourself) to the extent of rendering it completely useless, so only touch what you're confident to and "know what you do". 

1. install the [Portainer add-on](https://github.com/hassio-addons/addon-portainer) from the Add-on store
2. Make sure to disable its `Protection mode`:
  ![image](https://user-images.githubusercontent.com/1125168/118788032-aa316800-b893-11eb-8567-f2122159f64c.png)
3. Start Portainer and `Open Web UI`
4. in the left menu,
    1. head to `Settings` > section *Hidden Containers* and remove `io.hass.type`: `addon`
    2. go to `Containers`, `addon_[…]_zigbee2mqtt`, `Console`, `Connect`
5. ℹ️ the location of zigbee-herdsman-converters for example is `/app/node_modules/zigbee-herdsman-converters`
6. make your adjustments by copying or `vi`'ing 
7. Still in portainer, go back to the add-on's container and `Restart`

## Alternative (without portainer)

1. Install and setup `Advanced SSH & Web Terminal` with disabled safe mode
2. run `docker ps` and see which container name is the zigbee2mqtt one. (eg. `addon_45df7312_zigbee2mqtt`)
3. build your whole application with `npm run build`
4. upload the resulting build to your HA instance (eg. vscode server via drag n drop)
5. execute `docker cp` (eg. `docker cp <the location of your build>/. <container_name>:/app/node_modules/zigbee-herdsman-converters`)
6. execute `docker restart <container name>`

⚠️ Note that restarting the add-on via Supervisor or further down the stack will revert the file changes.

After work is done, don't forget to clean up and reintroduce the safety measures:
1. re-add the filter `io.hass.type`: `addon` for *Hidden Containers*
2. re-activate the "Protection mode" of the Portainer
