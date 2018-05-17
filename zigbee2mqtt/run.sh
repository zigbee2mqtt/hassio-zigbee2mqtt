#!/bin/bash

CONFIG_PATH=/data/options.json

DATA_PATH=$(jq --raw-output ".data_path" $CONFIG_PATH)
DEBUG_ZIGBEE2MQTT=$(jq --raw-output "debug" $CONFIG_PATH)

python3 "$CONFIG_PATH" "$DATA_PATH"

if $DEBUG_ZIGBEE2MQTT; then
    DEBUG=* ZIGBEE2MQTT_DATA="$DATA_PATH" npm start
else
    ZIGBEE2MQTT_DATA="$DATA_PATH" npm start
fi
