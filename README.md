[![](https://images.microbadger.com/badges/image/masterfox/rsyslog.svg)](https://microbadger.com/images/masterfox/rsyslog "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/masterfox/rsyslog.svg)](https://microbadger.com/images/masterfox/rsyslog "Get your own version badge on microbadger.com")

## Rsyslog Dockerfile

Rsyslog running in a linux container as a server, listening on 514 (tcp and udp), and writing to /var/log/syslog.

### Usage

This container will listen on 514/udp, and 514/tcp and write it to /var/log/syslog.

Use command below to run:

    docker run --name rsyslogserver --rm  -p 514:514/udp -p 514:514 -v "./syslog:/var/log/syslog" masterfox/rsyslog 


Or For docker-compose

    version: '3.4'
    services:
      rsyslog:
        image: masterfox/rsyslog
        ports:
        - 514:514/udp
        - 514:514
        volumes:
        - "./syslog:/var/log/syslog"

