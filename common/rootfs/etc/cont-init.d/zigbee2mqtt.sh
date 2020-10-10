#!/usr/bin/with-contenv bashio
export DATA_PATH=$(bashio::config 'data_path') 
export MQTT_SERVER=$(bashio::config 'mqtt.server')
export MQTT_USER=$(bashio::config 'mqtt.user')
export MQTT_PASSWORD=$(bashio::config 'mqtt.password')
export DEBUG=""
if ! bashio::services.available "mqtt"; then
    bashio::exit.nok "No internal MQTT service found. Please install Mosquitto broker"
else
    bashio::log.info "MQTT service found, fetching server detail ..."
    if ! bashio::config.exists 'mqtt.server'; then
        bashio::log.info "MQTT server not found in configuration, auto-discovering ..."
        MQTT_PREFIX="mqtt://"
        if [ $(bashio::services mqtt "ssl") = true ]; then
            MQTT_PREFIX="mqtts://"
        fi
        MQTT_SERVER="$MQTT_PREFIX$(bashio::services mqtt "host"):$(bashio::services mqtt "port")"
        bashio::log.info "Received server: '$MQTT_SERVER' for MQTT!"
    fi
    if ! bashio::config.exists 'mqtt.user'; then
        bashio::log.info "MQTT credentials not found in configuration, auto-discovering ..."
        MQTT_USER=$(bashio::services mqtt "username")
        MQTT_PASSWORD=$(bashio::services mqtt "password")
        bashio::log.info "Received user: '$MQTT_USER' for MQTT!"
    fi
fi

bashio::log.info "Checking if $DATA_PATH exists"
if ! bashio::fs.directory_exists "$DATA_PATH"; then
    bashio::log.warning "Data path not found"
    bashio::log.info "Creating $DATA_PATH"
    mkdir -p "$DATA_PATH" || bashio::exit.nok "Could not create $DATA_PATH"
else
    bashio::log.info "Check if there was a previous configuration"
    if bashio::fs.file_exists "$DATA_PATH/configuration.yaml"; then
        bashio::log.info "Previous configuration found, checking backup"
        if ! bashio::fs.file_exists "$DATA_PATH/configuration.yaml.bk"; then
            bashio::log.info "Creating backup config in '$DATA_PATH/.configuration.yaml.bk'"
            cp $DATA_PATH/configuration.yaml $DATA_PATH/.configuration.yaml.bk
        else
            bashio::log.info "Backup already exists, skipping"
        fi
    else
        bashio::log.warning "No configuration found yet to backup"
    fi
fi

bashio::log.info "Check if any custom devices.js manipulation required"
if bashio::config.true 'zigbee_devices'; then
    bashio::log.info "Searching for custom devices.js file in zigbee2mqtt data path..."
    if bashio::fs.file_exists "$DATA_PATH/devices.js"; then
        bashio::log.info "File devices.js found, copying to ./node_modules/zigbee-herdsman-converters/"
        cp -f "$DATA_PATH"/devices.js ./node_modules/zigbee-herdsman-converters/devices.js
    else
        bashio::log.warning "No devices.js file found in data path, starting with default devices.js"
    fi
else
    bashio::log.info "No devices.js file manipulation required"
fi

if bashio::config.true 'zigbee_herdsman_debug'; then
    bashio::log.info "Zigbee Herdsman debug logging enabled"
    DEBUG="zigbee-herdsman:*"
fi

CONFIG_PATH=/data/options.json
bashio::log.info "Adjusting Zigbee2mqtt core yaml configuration with add-on quirks ..."
cat "$CONFIG_PATH" | jq 'del(.data_path, .zigbee_devices, .socat)' \
    | jq 'if .advanced.ext_pan_id_string then .advanced.ext_pan_id = (.advanced.ext_pan_id_string | (split(",")|map(tonumber))) | del(.advanced.ext_pan_id_string) else . end' \
    | jq 'if .advanced.network_key_string then .advanced.network_key = (.advanced.network_key_string | (split(",")|map(tonumber))) | del(.advanced.network_key_string) else . end' \
    | jq 'if .device_options_string then .device_options = (.device_options_string|fromjson) | del(.device_options_string) else . end' \
    | MQTT_USER="$MQTT_USER"  jq '.mqtt.user=env.MQTT_USER' \
    | MQTT_PASSWORD="$MQTT_PASSWORD" jq '.mqtt.password=env.MQTT_PASSWORD' \
    | MQTT_SERVER="$MQTT_SERVER" jq '.mqtt.server=env.MQTT_SERVER' \
    > $DATA_PATH/configuration.yaml
