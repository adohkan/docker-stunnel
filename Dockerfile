FROM alpine:3.7

RUN apk add --update --no-cache tini stunnel \
  && mkdir -p /opt/stunnel/etc \
  && mkdir -p /opt/stunnel/run \
  && chown -R stunnel: /opt/stunnel

# These certs are used as placeholder
COPY certs /etc/stunnel/certs
COPY entrypoint.sh /entrypoint.sh

USER stunnel
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
