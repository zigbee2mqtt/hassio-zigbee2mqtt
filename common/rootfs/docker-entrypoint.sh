#!/usr/bin/env bashio

bashio::log.info "Preparing to start..."

# Check if HA supervisor started
# Workaround for:
# - https://github.com/home-assistant/supervisor/issues/3884
# - https://github.com/zigbee2mqtt/hassio-zigbee2mqtt/issues/387
bashio::config.require 'data_path'

# Socat
if bashio::config.true 'socat.enabled'; then
    bashio::log.info "Socat enabled"
    SOCAT_MASTER=$(bashio::config 'socat.master')
    SOCAT_SLAVE=$(bashio::config 'socat.slave')

    # Validate input
    if [[ -z "$SOCAT_MASTER" ]]; then
    bashio::exit.nok "Socat is enabled but not started because no master address specified"
    fi
    if [[ -z "$SOCAT_SLAVE" ]]; then
    bashio::exit.nok "Socat is enabled but not started because no slave address specified"
    fi
    bashio::log.info "Starting socat"

    DATA_PATH=$(bashio::config 'data_path')
    SOCAT_OPTIONS=$(bashio::config 'socat.options')

    # Socat start configuration
    bashio::log.blue "Socat startup parameters:"
    bashio::log.blue "Options:     $SOCAT_OPTIONS"
    bashio::log.blue "Master:      $SOCAT_MASTER"
    bashio::log.blue "Slave:       $SOCAT_SLAVE"

    bashio::log.info "Starting socat process ..."
    exec socat $SOCAT_OPTIONS $SOCAT_MASTER $SOCAT_SLAVE &

    bashio::log.debug "Modifying process for logging if required"
    if bashio::config.true 'socat.log'; then
        bashio::log.debug "Socat loggin enabled, setting file path to $DATA_PATH/socat.log"
        exec &>"$DATA_PATH/socat.log" 2>&1
    else
    bashio::log.debug "No logging required"
    fi
else
    bashio::log.info "Socat not enabled"
fi

export ZIGBEE2MQTT_DATA="$(bashio::config 'data_path')"
mkdir -p "$ZIGBEE2MQTT_DATA" || bashio::exit.nok "Could not create $ZIGBEE2MQTT_DATA"

if bashio::config.has_value 'watchdog'; then
    export Z2M_WATCHDOG="$(bashio::config 'watchdog')"
    bashio::log.info "Enabled Zigbee2MQTT watchdog with value '$Z2M_WATCHDOG'"
fi

export NODE_PATH=/app/node_modules
export ZIGBEE2MQTT_CONFIG_FRONTEND_ENABLED='true'
export ZIGBEE2MQTT_CONFIG_FRONTEND_PORT='8099'
export ZIGBEE2MQTT_CONFIG_HOMEASSISTANT_ENABLED='true'
export Z2M_ONBOARD_URL='http://0.0.0.0:8099'

if bashio::config.true 'force_onboarding'; then
    export Z2M_ONBOARD_FORCE_RUN="1"
    bashio::log.info "Forcing onboard to run"
fi

if bashio::config.true 'disable_tuya_default_response'; then
    bashio::log.info "Disabling TuYa default responses"
    export DISABLE_TUYA_DEFAULT_RESPONSE="true"
fi

# Expose addon configuration through environment variables.
function export_config() {
    local key=${1}
    local subkey

    if bashio::config.is_empty "${key}"; then
        return
    fi

    for subkey in $(bashio::jq "$(bashio::config "${key}")" 'keys[]'); do
        export "ZIGBEE2MQTT_CONFIG_$(bashio::string.upper "${key}")_$(bashio::string.upper "${subkey}")=$(bashio::config "${key}.${subkey}")"
    done
}

export_config 'mqtt'
export_config 'serial'

export TZ="$(bashio::supervisor.timezone)"

if (bashio::config.is_empty 'mqtt' || ! (bashio::config.has_value 'mqtt.server' || bashio::config.has_value 'mqtt.user' || bashio::config.has_value 'mqtt.password')) && bashio::var.has_value "$(bashio::services 'mqtt')"; then
    if bashio::var.true "$(bashio::services 'mqtt' 'ssl')"; then
        export ZIGBEE2MQTT_CONFIG_MQTT_SERVER="mqtts://$(bashio::services 'mqtt' 'host'):$(bashio::services 'mqtt' 'port')"
    else
        export ZIGBEE2MQTT_CONFIG_MQTT_SERVER="mqtt://$(bashio::services 'mqtt' 'host'):$(bashio::services 'mqtt' 'port')"
    fi
    export ZIGBEE2MQTT_CONFIG_MQTT_USER="$(bashio::services 'mqtt' 'username')"
    export ZIGBEE2MQTT_CONFIG_MQTT_PASSWORD="$(bashio::services 'mqtt' 'password')"
fi

bashio::log.info "Starting Zigbee2MQTT..."
cd /app
exec node index.js
