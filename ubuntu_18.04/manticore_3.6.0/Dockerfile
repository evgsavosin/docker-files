FROM ubuntu:18.04

# Base installation
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get install -y wget && \
    apt-get install -y default-libmysqlclient-dev

# User
RUN groupadd -r manticore && useradd -r -g manticore manticore

# Download manticore search packages
RUN wget -qO - https://repo.manticoresearch.com/GPG-KEY-manticore | apt-key add - && \
    wget https://repo.manticoresearch.com/manticore-repo.noarch.deb && \
    dpkg -i manticore-repo.noarch.deb && \
    apt-get update && \
    apt-get install -y manticore manticore-columnar-lib && \
    mkdir -p /var/run/manticore && mkdir -p /var/lib/manticore/replication && \
    mkdir -p /var/lib/manticore/data

# Listen ports
EXPOSE 9306
EXPOSE 9312
EXPOSE 9308

# Workdir
WORKDIR /var/lib/manticore

# Start manticore
CMD ["searchd", "--nodetach"]
