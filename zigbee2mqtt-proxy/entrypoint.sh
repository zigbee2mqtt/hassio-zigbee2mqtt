#!/bin/sh

tempio -conf /data/options.json -template /nginx.conf.gtpl -out /tmp/nginx.conf
nginx -t -c /tmp/nginx.conf

exec nginx -c /tmp/nginx.conf