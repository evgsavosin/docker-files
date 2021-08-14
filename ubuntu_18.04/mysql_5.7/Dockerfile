FROM ubuntu:18.04

RUN groupadd -r mysql && \
    useradd -r -g mysql mysql

RUN apt-get update && \
    apt-get install -y \
    locales \
    tzdata

RUN locale-gen en_US.UTF-8 && \
    ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    mysql-server

RUN rm -rf /var/lib/mysql && \
    mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/log/mysql && \
    sed -e "s/^bind-address\(.*\)=.*/bind-address = 0.0.0.0/" -i /etc/mysql/mysql.conf.d/mysqld.cnf

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/var/lib/mysql", "/var/log/mysql"]

COPY ./entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["/usr/sbin/mysqld"]
