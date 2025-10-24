FROM alpine:3.22
ARG ALL_ARGS=""
ENV ALL_ARGS="${ALL_ARGS}"
COPY entrypoint.sh /entrypoint.sh
RUN apk --no-cache update && apk add --no-cache curl pdns pdns-backend-sqlite3 pdns-doc sqlite \
    && mkdir -p /var/lib/powerdns \
    && sqlite3 /var/lib/powerdns/pdns.sqlite3 < /usr/share/doc/pdns/schema.sqlite3.sql \
    && chown -R pdns:pdns /var/lib/powerdns \
    && chmod +x /entrypoint.sh 
EXPOSE 53/tcp 53/udp 8081
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]