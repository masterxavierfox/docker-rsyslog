FROM alpine
MAINTAINER Xavier Fox <tech@foxwilltech.com>

RUN apk add --no-cache rsyslog

COPY ./rsyslograd.conf /etc/rsyslog.conf
RUN mkdir /var/spool/rsyslog

ENV FILEBEAT_VERSION=6.7.1

COPY ./filebeat.yml /

RUN apk add --update-cache curl bash libc6-compat && \
    rm -rf /var/cache/apk/* && \
    curl https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -o /filebeat.tar.gz && \
    tar xzvf filebeat.tar.gz && \
    rm filebeat.tar.gz && \
    mv filebeat-${FILEBEAT_VERSION}-linux-x86_64 filebeat && \
    cd filebeat && \
    cp filebeat /usr/bin && \
    rm -rf /filebeat/filebeat.yml && \
    cp /filebeat.yml /filebeat/ && \
    ls -ltr /filebeat && \
    cat /filebeat/filebeat.yml

VOLUME /filebeat/data

WORKDIR /filebeat/

EXPOSE 514/tcp 514/udp

CMD rsyslogd -f /etc/rsyslog.conf && ./filebeat -e -c filebeat.yml