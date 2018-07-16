#!/bin/bash

CONFIG_PATH=/data/options.json

DATA_PATH=$(jq --raw-output ".data_path" $CONFIG_PATH)
DEBUG_ZIGBEE2MQTT=$(jq --raw-output ".debug // empty" $CONFIG_PATH)
ERR_LOG=$(jq --raw-output ".err // empty" $CONFIG_PATH)

python3 set_config.py "$CONFIG_PATH" "$DATA_PATH"

if [[ ! -z "$DEBUG_ZIGBEE2MQTT" ]]; then
    export DEBUG=*
fi


if [[ ! -z "$ERR_LOG" ]]; then
    ZIGBEE2MQTT_DATA="$DATA_PATH" npm start 1> "$DATA_PATH"/out.log 2> "$DATA_PATH"/err.log
else
    ZIGBEE2MQTT_DATA="$DATA_PATH" pm2-runtime start npm -- start
fi
