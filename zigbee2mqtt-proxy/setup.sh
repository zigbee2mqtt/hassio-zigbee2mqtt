#!/usr/bin/bashio
CONFIG_PATH=/data/options.json
SERVER=$(bashio::config 'server')

echo $SERVER
bashio::var.json \
    server "$SERVER" \
    | tempio \
        -template /nginx.conf.gtpl \
        -out /tmp/nginx.conf
nginx -T -c /tmp/nginx.conf