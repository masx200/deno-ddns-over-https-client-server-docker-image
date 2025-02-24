#!/bin/bash


if [ -z "$APP_INTERFACE" ]; then
    export APP_INTERFACE="true"
    
fi
echo "APP_INTERFACE:$APP_INTERFACE"

if [ -z "$APP_TOKEN" ]; then
    export APP_TOKEN="************************************"
    
fi
echo "APP_TOKEN:$APP_TOKEN"


if [ -z "$APP_SERVE_PORT" ]; then
    export APP_SERVE_PORT="48000"
    
fi
echo "APP_SERVE_PORT:$APP_SERVE_PORT"



if [ -z "$DDNS_DOMAIN" ]; then
    export DDNS_DOMAIN="**********************"
    
fi
echo "DDNS_DOMAIN:$DDNS_DOMAIN"
cd /root/deno-ddns-over-https-client-main
rm deno.lock
while true
do
    deno run -A --unstable-kv --unstable-net "run_ddns_interval_client.ts" "--name=$DDNS_DOMAIN" "--service_url=http://127.0.0.1:$APP_SERVE_PORT/dns_records" "--token=$APP_TOKEN" --private=true --public=true --tailscale=true --interfaces="$APP_INTERFACE"
done

# deno run -A "run_ddns_interval_client.ts" "--name=**********************" "--service_url=http://127.0.0.1:48000/dns_records" "--token=************************************" --private=true --public=true --tailscale=true --interfaces=true
