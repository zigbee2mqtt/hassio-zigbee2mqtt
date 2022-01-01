#!/bin/bash

CONFIG_PATH=/data/options.json

DATA_PATH=$(jq --raw-output ".data_path" $CONFIG_PATH)

ZIGBEE_SHEPHERD_DEBUG=$(jq --raw-output ".zigbee_shepherd_debug // empty" $CONFIG_PATH)
ZIGBEE_SHEPHERD_DEVICES=$(jq --raw-output ".zigbee_shepherd_devices // empty" $CONFIG_PATH)

python3 set_config.py "$CONFIG_PATH" "$DATA_PATH"

if [[ ! -z "$ZIGBEE_SHEPHERD_DEBUG" ]]; then
    export DEBUG="zigbee-shepherd*" 
fi

if [[ ! -z "$ZIGBEE_SHEPHERD_DEVICES" ]]; then
    echo "[Info] Searching for custom devices file in zigbee2mqtt data path..." 
    if [[ -f "$DATA_PATH"/devices.js ]]; then
        cp -f "$DATA_PATH"/devices.js ./node_modules/zigbee-shepherd-converters/devices.js
    else
        echo "[Error] File $DATA_PATH/devices.js not found! Starting with default devices.js"
    fi
fi

ZIGBEE2MQTT_DATA="$DATA_PATH" pm2-runtime start npm -- start
