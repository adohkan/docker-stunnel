# README

## Abstract

This is a lightweight Docker image that contains a pre-configured `stunnel` instance, based on `alpine`.

The idea is to have a generic `stunnel` image that we can easily inject as `side-container` into pods that need to provide secured connection.

## Usage

By default,
* the image expect `tls.crt` and `tls.key` files to be provided in `/etc/stunnel/certs/`,
* will listen for encrypted traffic on `:8443`, and send it to `localhost:8000`

Behaviour can be tweaked using the following environment variables:

| environment variable |        description         |          default           |
|----------------------|----------------------------|----------------------------|
| STUNNEL_ACCEPT       | accept connection on       | 8443                       |
| STUNNEL_CONNECT      | send traffic to (upstream) | 8000                       |
| STUNNEL_CERT         | TLS cert                   | /etc/stunnel/certs/tls.crt |
| STUNNEL_KEY          | TLS cert's key             | /etc/stunnel/certs/tls.key |
|                      |                            |                            |

## Example

```
docker-compose up
curl -vk https://localhost:8443
```

## Docker registry

https://hub.docker.com/r/adohkan/stunnel/
