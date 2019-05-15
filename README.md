[![](https://images.microbadger.com/badges/image/masterfox/rsyslog.svg)](https://microbadger.com/images/masterfox/rsyslog "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/masterfox/rsyslog.svg)](https://microbadger.com/images/masterfox/rsyslog "Get your own version badge on microbadger.com")

## Rsyslog + Filebeat Dockerfile

Rsyslog running in a linux container as a server, listening on 514 (tcp and udp), and writing to /var/log/syslog; which will be sent to ELK stack via filebeat agent.

### Deploy

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


Run below compose command to use compose file in repo:

    docker-compose up

To deploy to kubernetes run the comand below from the root to deploy the helm chart:

    helm install --namespace "development" -n "radrsyslog" ./radrsyslog


### To Build

The file beat agent connectt to elastic cloud kibana so make sure to set your cloud credentials in the build command below or in the filebeat.yml

run: 

    docker build -e CLOUD_ID=12345678 -e CLOUD_AUTH=lkghjghjfhgjkftyguhi -t masterfox/rsyslog .