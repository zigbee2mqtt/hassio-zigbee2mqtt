#!/bin/bash

CONFIG_PATH=/data/options.json

# modify the configuration.yaml based on the config passed to this add-on

homeassistant=$(jq --raw-output ".homeassistant" $CONFIG_PATH)
permit_join=$(jq --raw-output ".permit_join" $CONFIG_PATH)
mqtt_base_topic=$(jq --raw-output ".mqtt_base_topic" $CONFIG_PATH)
mqtt_server=$(jq --raw-output ".mqtt_server" $CONFIG_PATH)
serial_port=$(jq --raw-output ".serial_port" $CONFIG_PATH)

mqtt_user=$(jq --raw-output ".mqtt_user" // empty $CONFIG_PATH)
mqtt_pass=$(jq --raw-output ".mqtt_pass" // empty $CONFIG_PATH)

if [[ -z "$mqtt_user" ]]; then
    echo "[Info] Setting configuraiton with MQTT user and password..."
    python3 /app/set_config.py --homeassistant "$homeassistant" --permit_join "$permit_join" --mqtt_base_topic "$mqtt_base_topic" --mqtt_server "$mqtt_server" --serial_port "$serial_port"
else
echo "[Info] Setting configuraiton.yaml..."
    python3 /app/set_config.py --homeassistant "$homeassistant" --permit_join "$permit_join" --mqtt_base_topic "$mqtt_base_topic" --mqtt_server "$mqtt_server" --serial_port "$serial_port" --mqtt_user="$mqtt_user" --mqtt_pass="$mqtt_pass"
fi

npm run
