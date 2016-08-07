FROM ubuntu:16.04
MAINTAINER Marco Bonezzi "marco@mongodb.com"

ENV REFRESHED_AT 2016-04-20
COPY automation-entrypoint.sh /entrypoint.sh
RUN apt-get -qqy update && \
    apt-get install -qqy \
        curl \
        ca-certificates \
        libsasl2-2 \
        numactl


#VOLUME /var/lib/mongodb-mms-automation
ADD https://cloud.mongodb.com/download/agent/automation/mongodb-mms-automation-agent-manager_latest_amd64.deb /root/mongodb-mms-automation-agent-manager_latest_amd64.deb

RUN dpkg -i /root/mongodb-mms-automation-agent-manager_latest_amd64.deb

#Setting /var/lib permissions
RUN chmod -R 777 /var/lib/


# MMS automation
# MongoDB data volume
VOLUME /data
RUN chown -R mongodb:mongodb /data
USER mongodb

# default MMS automation port
EXPOSE 27000

ENTRYPOINT ["/opt/mongodb-mms-automation/bin/mongodb-mms-automation-agent"]
#ENTRYPOINT ["/entrypoint.sh"]