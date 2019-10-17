#!/bin/bash
# Configuration and variables
CONFIG_PATH=$1
EXEC_TYPE=$2
DATA_PATH=$(jq --raw-output ".data_path" $CONFIG_PATH)
SOCAT_ENABLED=$(jq --raw-output ".socat.enabled // empty" $CONFIG_PATH)
SOCAT_MASTER=$(jq --raw-output ".socat.master // empty" $CONFIG_PATH)
SOCAT_SLAVE=$(jq --raw-output ".socat.slave // empty" $CONFIG_PATH)
SOCAT_OPTIONS=$(jq --raw-output ".socat.options // empty" $CONFIG_PATH)
SOCAT_INITDELAY=$(jq --raw-output ".socat.initialdelay // 1" $CONFIG_PATH)
SOCAT_RESTDELAY=$(jq --raw-output ".socat.restartdelay // 1" $CONFIG_PATH)
SOCAT_LOG=$(jq --raw-output ".socat.log // empty" $CONFIG_PATH)
SCRIPT_PATH=$(realpath "$0")

# Validate input
if [[ -z "$SOCAT_MASTER" ]]; then
  echo "[Info] Socat is enabled but not started because no master address specified"
  exit 0
fi
if [[ -z "$SOCAT_SLAVE" ]]; then
  echo "[Info] Socat is enabled but not started because no slave address specified"
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

# Forked process, start the socat process within a loop.
if [[ $EXEC_TYPE = "fork" ]]; then
  while true; do
    # Start socat process. This will terminate when when pipe is terminated
    echo "[Info] Starting socat process"  
	if [[ -z "$SOCAT_LOGFILE" ]]; then
      socat $SOCAT_OPTIONS $SOCAT_MASTER $SOCAT_SLAVE 
    else
	  socat $SOCAT_OPTIONS $SOCAT_MASTER $SOCAT_SLAVE > $SOCAT_LOGFILE 2>&1
	fi
	
    # Do a sleep after the socat has terminated unexpectedly.
    echo "[Info] Socat process terminated, restarting after $SOCAT_RESTDELAY sec"  
    sleep $SOCAT_RESTDELAY
  done
  exit 0
fi


# Stop/skip when not enabled or when mandatory variables are empty
if [[ -z "$SOCAT_ENABLED" ]] || [[ "$SOCAT_ENABLED" = false ]]; then
  echo "[Info] Socat is DISABLED and not started"
  exit 0
fi
echo "[Info] Socat is ENABLED"

# If there is a log file, print the last 25 lines
if [[ -f "$SOCAT_LOGFILE" ]]; then
  echo "[Info] Last 50 lines of the previous socat log file:"
  tail -n 50 $SOCAT_LOGFILE 
  echo "[Info] End of socat log file"
fi

# Start socat by forking this script
echo "[Info] Starting socat with:"
echo "[Info] Options:     $SOCAT_OPTIONS"
echo "[Info] Master:      $SOCAT_MASTER"
echo "[Info] Slave:       $SOCAT_SLAVE"
echo "[Info] Logfile:     $SOCAT_LOGFILE"
echo "[Info] Retrydelay:  $SOCAT_RESTDELAY seconds"
$SCRIPT_PATH $CONFIG_PATH fork &

# Do an initial sleep
sleep $SOCAT_INITDELAY