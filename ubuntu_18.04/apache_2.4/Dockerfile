FROM ubuntu:18.04

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid

RUN ln -snf /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo Europe/Moscow > /etc/timezone

RUN apt-get update && \
    apt-get install -y \
    apache2 \
    apache2-utils \
    libapache2-mod-php

RUN a2enmod rewrite && \
    a2enmod ssl && \
    a2enmod proxy && \
    a2enmod proxy_fcgi

RUN mkdir -p $APACHE_RUN_DIR && \
    mkdir -p $APACHE_LOCK_DIR && \
    mkdir -p $APACHE_LOG_DIR

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 80 443

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]