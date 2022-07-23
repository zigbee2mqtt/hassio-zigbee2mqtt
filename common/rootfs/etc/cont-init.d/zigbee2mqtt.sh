#!/usr/bin/with-contenv bashio
DATA_PATH=$(bashio::config 'data_path')

if ! bashio::fs.file_exists "$DATA_PATH/configuration.yaml"; then
    mkdir -p "$DATA_PATH" || bashio::exit.nok "Could not create $DATA_PATH"

    cat <<EOF > "$DATA_PATH/configuration.yaml"
homeassistant: true
EOF
fi
