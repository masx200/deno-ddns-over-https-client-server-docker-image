FROM masx200/deno-ddns-over-https-client-deno-dns-over-https-server:1.8.2

WORKDIR /root
COPY ./entry.sh /root/entry.sh
# COPY ./start.sh /root/start.sh
COPY ./deno-dns-over-https-server.sh /root/deno-dns-over-https-server.sh

COPY ./deno-ddns-over-https-client.sh /root/deno-ddns-over-https-client.sh

COPY ./deno-dns-over-https-server-main /root/deno-dns-over-https-server-main

COPY ./deno-ddns-over-https-client-main /root/deno-ddns-over-https-client-main


CMD ["/bin/bash", "-i", "/root/entry.sh"]

ENV TZ=Asia/Shanghai


ENV PATH=/usr/local/bin:/root/deno-v-2.0.2:/root/node-v20.18.0-linux-x64/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/root/tailscale

RUN chmod 777 /root/deno-ddns-over-https-client.sh && chmod 777  /root/*.sh

RUN bash -c "find . -maxdepth 1 -type f -name \"*.sh\" -exec dos2unix {} \;"


RUN rm -fvr /root/deno-dns-over-https-server-main/node_modules && rm -fvr /root/deno-dns-over-https-server-main/static/node_modules && cd /root/deno-dns-over-https-server-main && deno cache --allow-import "main.tsx" && rm -fvr /root/deno-dns-over-https-server-main/deno.lock

RUN rm -fvr /root/deno-ddns-over-https-client-main/node_modules  && cd /root/deno-ddns-over-https-client-main && deno cache --allow-import "run_ddns_interval_client.ts" && rm -fvr /root/deno-ddns-over-https-client-main/deno.lock

RUN rm -frv /deno/*