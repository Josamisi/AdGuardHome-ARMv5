
FROM arm32v5/debian:bookworm-slim

ARG VERSION

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates curl tar; \
    rm -rf /var/lib/apt/lists/*; \
    test -n "$VERSION"; \
    curl -fL --retry 3 \
      "https://github.com/AdguardTeam/AdGuardHome/releases/download/v${VERSION}/AdGuardHome_linux_armv5.tar.gz" \
      -o /tmp/adguardhome.tar.gz; \
    tar -xzf /tmp/adguardhome.tar.gz \
      --strip-components=1 \
      -C /opt \
      AdGuardHome/AdGuardHome; \
    rm /tmp/adguardhome.tar.gz

WORKDIR /opt

EXPOSE 53/tcp 53/udp 3000/tcp 8084/tcp

VOLUME ["/opt/adguardhome/conf", "/opt/adguardhome/work"]

ENTRYPOINT ["/opt/AdGuardHome"]
CMD ["--work-dir", "/opt/adguardhome/work", "--config", "/opt/adguardhome/conf/AdGuardHome.yaml"]
