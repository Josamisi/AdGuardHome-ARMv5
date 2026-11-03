
FROM arm32v5/debian:bookworm-slim

WORKDIR /opt/adguardhome

COPY AdGuardHome /opt/adguardhome/AdGuardHome
COPY ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

EXPOSE 53/tcp 53/udp 3000/tcp 8084/tcp

VOLUME ["/opt/adguardhome/conf", "/opt/adguardhome/work"]

ENTRYPOINT ["./AdGuardHome"]
CMD ["--work-dir", "/opt/adguardhome/work", "--config", "/opt/adguardhome/conf/AdGuardHome.yaml"]
