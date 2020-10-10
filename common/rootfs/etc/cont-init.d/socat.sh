#!/usr/bin/with-contenv bashio
# Configuration and variables
export DATA_PATH=$(bashio::config 'data_path')
export SOCAT_ENABLED=$(bashio::config 'socat.enabled')
export SOCAT_MASTER=$(bashio::config 'socat.master')
export SOCAT_SLAVE=$(bashio::config 'socat.slave')
export SOCAT_OPTIONS=$(bashio::config 'socat.options')
export SOCAT_INITDELAY=$(bashio::config 'socat.initialdelay')
export SOCAT_RESTDELAY=$(bashio::config 'socat.restartdelay')
export SOCAT_LOG=$(bashio::config 'socat.log')

# Validate input
if [[ -z "$SOCAT_MASTER" ]]; then
  bashio::exit.nok "Socat is enabled but not started because no master address specified"
fi
if [[ -z "$SOCAT_SLAVE" ]]; then
  bashio::exit.nok "Socat is enabled but not started because no slave address specified"
fi
if (("$SOCAT_RESTDELAY" <= "0")); then
  SOCAT_RESTDELAY=0
fi
if (("$SOCAT_INITDELAY" <= "0")); then
  SOCAT_INITDELAY=0
fi
if [[ ! -z "$SOCAT_LOG" ]] && [[ "$SOCAT_LOG" = true ]]; then
  SOCAT_LOGFILE="$DATA_PATH/socat.log"
else
  SOCAT_LOGFILE=""
fi

# Socat start configuration
bashio::log.blue "Socat startup parameters:"
bashio::log.blue "Options:     $SOCAT_OPTIONS"
bashio::log.blue "Master:      $SOCAT_MASTER"
bashio::log.blue "Slave:       $SOCAT_SLAVE"
bashio::log.blue "Logfile:     $SOCAT_LOGFILE"
bashio::log.blue "Retrydelay:  $SOCAT_RESTDELAY seconds"