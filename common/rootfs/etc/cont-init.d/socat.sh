#!/usr/bin/with-contenv bashio
SOCAT_MASTER=$(bashio::config 'socat.master')
SOCAT_SLAVE=$(bashio::config 'socat.slave')

bashio::log.debug "Check if socat is required"
if bashio::config.true 'socat.enabled'; then
    # Validate input
    if [[ -z "$SOCAT_MASTER" ]]; then
    bashio::exit.nok "Socat is enabled but not started because no master address specified"
    fi
    if [[ -z "$SOCAT_SLAVE" ]]; then
    bashio::exit.nok "Socat is enabled but not started because no slave address specified"
    fi
else
    bashio::log.info "Socat not enabled, marking service as down"
    touch /etc/services.d/socat/down
fi

    
