#!/bin/sh

set -ue

STUNNEL_CONFIG=/opt/stunnel/etc/stunnel.conf

STUNNEL_ACCEPT=${STUNNEL_ACCEPT:-8443}
STUNNEL_CONNECT=${STUNNEL_CONNECT:-8000}
STUNNEL_CERT=${STUNNEL_CERT:-/etc/stunnel/certs/tls.crt}
STUNNEL_KEY=${STUNNEL_KEY:-/etc/stunnel/certs/tls.key}

cat << EOF > ${STUNNEL_CONFIG:?}
# reference: https://www.stunnel.org/static/stunnel.html

pid = /opt/stunnel/run/stunnel.pid
# don't fork & send logs to stdout as we're in a container
foreground = yes

# Some performance tunings
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

# setup TLS certs
# mount your certificate secret into '/etc/stunnel/certs'
cert = ${STUNNEL_CERT:?}
key = ${STUNNEL_KEY:?}

[generic]
# set listening interfaces
# ========================
# accept = [HOST:]PORT
# //  If no host specified, defaults to all IPv4 addresses for the local host.
accept = ${STUNNEL_ACCEPT:?}

# set upstream
# ============
# connect = [HOST:]PORT
# //  If no host is specified, the host defaults to localhost.
connect = ${STUNNEL_CONNECT:?}
EOF

exec /usr/bin/stunnel ${STUNNEL_CONFIG:?}
