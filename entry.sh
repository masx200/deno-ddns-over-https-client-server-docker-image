#!/bin/bash
# 假设环境变量VAR需要检查是否为空
printenv
echo "DDNS_DOMAIN:$DDNS_DOMAIN"
echo "mongodb_url:$mongodb_url"
echo "mongodb_collection:$mongodb_collection"
echo "mongodb_db:$mongodb_db"

rm deno-dns-over-https-server.log
rm deno-ddns-over-https-client.log
# sh start.sh
echo "DDNS_DOMAIN:$DDNS_DOMAIN"
echo "mongodb_url:$mongodb_url"
echo "mongodb_collection:$mongodb_collection"
echo "mongodb_db:$mongodb_db"

nohup sh /root/deno-dns-over-https-server.sh >>/root/deno-dns-over-https-server.log 2>&1 &

nohup sh /root/deno-ddns-over-https-client.sh >>/root/deno-ddns-over-https-client.log 2>&1 &

touch deno-ddns-over-https-client.log
touch deno-dns-over-https-server.log

cat deno-ddns-over-https-client.log
cat deno-dns-over-https-server.log

tail -f deno-ddns-over-https-client.log &
tail -f deno-dns-over-https-server.log &
tail -f /dev/null
