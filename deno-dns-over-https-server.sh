#!/bin/bash

if [ -z "$APP_DOH" ]; then
    export APP_DOH="https://dns.alidns.com/dns-query"
    
fi
echo "APP_DOH:$APP_DOH"
if [ -z "$APP_TOKEN" ]; then
    export APP_TOKEN="************************************"
    
fi
echo "APP_TOKEN:$APP_TOKEN"

if [ -z "$APP_SERVE_PORT" ]; then
    export APP_SERVE_PORT="48000"
    
fi
echo "APP_SERVE_PORT:$APP_SERVE_PORT"


if [ -z "$mongodb_url" ]; then
    export mongodb_url="mongodb+srv://deno-dns-over-https-server:****************@****************************/?authMechanism=SCRAM-SHA-1&amp;tls=true"
    
fi
if [ -z "$mongodb_collection" ]; then
    export mongodb_collection="deno-dns-over-https-server"
    
fi
if [ -z "$mongodb_db" ]; then
    export mongodb_db="deno-dns-over-https-server"
    
fi
echo "mongodb_url:$mongodb_url"
echo "mongodb_collection:$mongodb_collection"
echo "mongodb_db:$mongodb_db"

cd /root/deno-dns-over-https-server-main
rm deno.lock
while true
do
    npx -y cross-env "doh=$APP_DOH" ttl=300 "token=$APP_TOKEN" "mongodb_url=$mongodb_url" "mongodb_collection=$mongodb_collection" "mongodb_db=$mongodb_db" deno run --unstable-kv --unstable-net -A main.tsx "--port=$APP_SERVE_PORT"
done

# npx -y cross-env "doh=https://dns.alidns.com/dns-query" ttl=300 "token=************************************" "mongodb_url=mongodb+srv://deno-dns-over-https-server:****************@****************************/?authMechanism=SCRAM-SHA-1&amp;tls=true" mongodb_collection=deno-dns-over-https-server mongodb_db=deno-dns-over-https-server deno run --unstable-kv -A main.tsx --port=48000
