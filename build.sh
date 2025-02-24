#!/bin/bash
set -e
chmod 777 ./*.sh
rm -fvr ./deno-dns-over-https-server-main/
rm -fvr ./deno-ddns-over-https-client-main/

rm -fvr ./deno-dns-over-https-server/
rm -fvr ./deno-ddns-over-https-client/
git clone https://github.com/masx200/deno-dns-over-https-server
git clone https://github.com/masx200/deno-ddns-over-https-client

mv  deno-dns-over-https-server deno-dns-over-https-server-main
mv  deno-ddns-over-https-client deno-ddns-over-https-client-main


cd deno-dns-over-https-server-main
cd static
npx -y cnpm install --force
npm run build
cd ../
cd ../
bash -c "find . -maxdepth 1 -type f -name \"*.sh\" -exec dos2unix {} \;"
rm -fvr ./deno-ddns-over-https-client-main/node_modules/
rm -fvr ./deno-ddns-over-https-client-main/deno.lock
rm -fvr ./deno-dns-over-https-server-main/static/node_modules/
rm -fvr ./deno-dns-over-https-server-main/node_modules/
rm -fvr ./deno-dns-over-https-server-main/deno.lock
VER_LATEST1=$(curl -fsSL "https://api.github.com/repos/masx200/deno-dns-over-https-server/releases/latest" | jq -r '.tag_name')
VER_LATEST2=$(curl -fsSL "https://api.github.com/repos/masx200/deno-ddns-over-https-client/releases/latest" | jq -r '.tag_name')
version="$VER_LATEST1-$VER_LATEST2"
echo "version=$version"
docker build -t "masx200/deno-ddns-over-https-client-deno-dns-over-https-server:temp" .
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock masx200/docker-squash:1.2.2 docker-squash -v -t "masx200/deno-ddns-over-https-client-deno-dns-over-https-server:$version" "masx200/deno-ddns-over-https-client-deno-dns-over-https-server:temp"
mkdir -pv ./build
docker save "masx200/deno-ddns-over-https-client-deno-dns-over-https-server:$version" |gzip > "./build/masx200-deno-ddns-over-https-client-deno-dns-over-https-server-$version.tgz"

