
FROM arm32v5/debian:bookworm-slim

ARG VERSION=0.107.80

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates tar wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/adguardhome

RUN wget -O /tmp/adguardhome.tar.gz \
    "https://static.adguard.com/adguardhome/release/AdGuardHome_linux_armv5.tar.gz" \
    && tar -xzf /tmp/adguardhome.tar.gz \
       --strip-components=1 \
       -C /opt/adguardhome \
       AdGuardHome/AdGuardHome \
    && rm /tmp/adguardhome.tar.gz

EXPOSE 53/tcp 53/udp 3000/tcp 8084/tcp

VOLUME ["/opt/adguardhome/conf", "/opt/adguardhome/work"]

ENTRYPOINT ["./AdGuardHome"]
CMD ["--work-dir", "/opt/adguardhome/work", "--config", "/opt/adguardhome/conf/AdGuardHome.yaml"]
