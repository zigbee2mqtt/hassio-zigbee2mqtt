#!/bin/bash

CONFIG_PATH=/data/options.json

DATA_PATH=$(jq --raw-output ".data_path" $CONFIG_PATH)

ZIGBEE_SHEPHERD_DEBUG=$(jq --raw-output ".zigbee_shepherd_debug // empty" $CONFIG_PATH)

python3 set_config.py "$CONFIG_PATH" "$DATA_PATH"

if [[ ! -z "$ZIGBEE_SHEPHERD_DEBUG" ]]; then
    export DEBUG="zigbee-shepherd*" 
fi

ZIGBEE2MQTT_DATA="$DATA_PATH" pm2-runtime start npm -- start
