#!/usr/bin/with-contenv bashio
# Configuration and variables
DATA_PATH=$(bashio::config 'data_path')
SOCAT_ENABLED=$(bashio::config 'socat.enabled')
SOCAT_MASTER=$(bashio::config 'socat.master')
SOCAT_SLAVE=$(bashio::config 'socat.slave')
SOCAT_OPTIONS=$(bashio::config 'socat.options')
SOCAT_INITDELAY=$(bashio::config 'socat.initialdelay')
SOCAT_RESTDELAY=$(bashio::config 'socat.restartdelay')
SOCAT_LOG=$(bashio::config 'socat.log')
EXEC_TYPE=${1:-initial}

# Validate input
if [[ -z "$SOCAT_MASTER" ]]; then
  bashio::log.warning "Socat is enabled but not started because no master address specified"
  exit 0
fi
if [[ -z "$SOCAT_SLAVE" ]]; then
  bashio::log.warning "Socat is enabled but not started because no slave address specified"
  exit 0
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

if [[ $EXEC_TYPE = "fork" ]]; then
  while true; do
    # Start socat process. This will terminate when when pipe is terminated
    if [[ -z "$SOCAT_LOGFILE" ]]; then
      socat $SOCAT_OPTIONS $SOCAT_MASTER $SOCAT_SLAVE
    else
      socat $SOCAT_OPTIONS $SOCAT_MASTER $SOCAT_SLAVE > $SOCAT_LOGFILE 2>&1
    fi
    # Do a sleep after the socat has terminated unexpectedly.
    bashio::log.warning "Socat process terminated, restarting after $SOCAT_RESTDELAY sec"
    sleep $SOCAT_RESTDELAY
  done
  exit 0
fi

bashio::log.info "Start socat as background process"
/app/socat.sh fork &

# Socat start configuration
bashio::log.blue "Socat startup parameters:"
bashio::log.blue "Options:     $SOCAT_OPTIONS"
bashio::log.blue "Master:      $SOCAT_MASTER"
bashio::log.blue "Slave:       $SOCAT_SLAVE"
bashio::log.blue "Logfile:     $SOCAT_LOGFILE"
bashio::log.blue "Retrydelay:  $SOCAT_RESTDELAY seconds"

# Do an initial sleep
sleep $SOCAT_INITDELAY