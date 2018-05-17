#!/bin/bash

CONFIG_PATH=/data/options.json

DATA_PATH=$(jq --raw-output ".data_path" $CONFIG_PATH)

python3 "$CONFIG_PATH" "$DATA_PATH"

ZIGBEE2MQTT_DATA="$DATA_PATH" npm start
