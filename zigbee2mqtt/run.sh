#!/bin/bash

CONFIG_PATH=/data/options.json

DATA_PATH=$(jq --raw-output ".data_path" $CONFIG_PATH)
ZIGBEE_SHEPHERD_DEBUG=$(jq --raw-output ".zigbee_shepherd_debug // empty" $CONFIG_PATH)
ZIGBEE_HERDSMAN_DEBUG=$(jq --raw-output ".zigbee_herdsman_debug // empty" $CONFIG_PATH)
ZIGBEE_SHEPHERD_DEVICES=$(jq --raw-output ".zigbee_shepherd_devices // empty" $CONFIG_PATH)

# Check if config exists already
mkdir -p $DATA_PATH
if [[ -f $DATA_PATH/configuration.yaml ]]; then
    if [[ ! -f $DATA_PATH/.configuration.yaml.bk ]]; then
        echo "[Info] Configuration file found in data path, but no backup file found in data path. Backing up existing configuration to ${DATA_PATH}/.configuration.yaml.bk"
        cp $DATA_PATH/configuration.yaml $DATA_PATH/.configuration.yaml.bk
    else
        "[Info] Configuration backup found in ${DATA_PATH}/.configuration.yaml.bk. Skipping config backup."
    fi
fi

# Parse config
cat "$CONFIG_PATH" | jq 'del(.data_path, .zigbee_shepherd_debug, .zigbee_shepherd_devices, .socat)' \
    | jq 'if .advanced.ext_pan_id_string then .advanced.ext_pan_id = (.advanced.ext_pan_id_string | (split(",")|map(tonumber))) | del(.advanced.ext_pan_id_string) else . end' \
    | jq 'if .advanced.network_key_string then .advanced.network_key = (.advanced.network_key_string | (split(",")|map(tonumber))) | del(.advanced.network_key_string) else . end' \
    > $DATA_PATH/configuration.yaml

if [[ ! -z "$ZIGBEE_SHEPHERD_DEBUG" ]]|| [[ ! -z "$ZIGBEE_HERDSMAN_DEBUG" ]]; then
    echo "[Info] Zigbee Herdsman debug logging enabled."
    export DEBUG="zigbee-herdsman*"
fi

if [[ ! -z "$ZIGBEE_SHEPHERD_DEVICES" ]]; then
    echo "[Info] Searching for custom devices file in zigbee2mqtt data path..." 
    if [[ -f "$DATA_PATH"/devices.js ]]; then
        cp -f "$DATA_PATH"/devices.js ./node_modules/zigbee-herdsman-converters/devices.js
    else
        echo "[Error] File $DATA_PATH/devices.js not found! Starting with default devices.js"
    fi
fi

# FORK SOCAT IN A SEPARATE PROCESS IF ENABLED
SOCAT_EXEC="$(dirname $0)/socat.sh"
$SOCAT_EXEC $CONFIG_PATH

# RUN zigbee2mqtt
ZIGBEE2MQTT_DATA="$DATA_PATH" pm2-runtime start npm -- start
