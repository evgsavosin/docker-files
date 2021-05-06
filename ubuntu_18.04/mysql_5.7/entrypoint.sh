#!/bin/bash

# Settings for /var/log/mysql/:
# 1) create local directory and change it user:group to something like 999:999 (check /var/lib/mysql/)
# 2) add volume `- ./mysql/log/:/var/log/mysql/` into docker-compose.yml

set -e

MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"password"}

# /var/lib/mysql
if [ ! -d /var/lib/mysql/mysql ]; then

    echo "initialize databases"
    /usr/sbin/mysqld --initialize --user=mysql >/dev/null 2>&1

    echo "start mysqld_safe"
    /usr/bin/mysqld_safe --skip-grant-tables >/dev/null 2>&1 &

    timeout=15
    while ! /usr/bin/mysqladmin --user=root status >/dev/null 2>&1
    do
        timeout=$(($timeout - 1))
        if [ $timeout -eq 0 ]; then
            echo -e "\nerror: connect to mysql server failed."
            exit 1
        fi
        sleep 1
    done

    echo "update root password"
    mysql --user=root --execute="UPDATE mysql.user SET authentication_string=PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE user='root'; FLUSH PRIVILEGES;" >/dev/null
    mysql --user=root --password=$MYSQL_ROOT_PASSWORD --connect-expired-password --execute="ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >/dev/null
    mysql --user=root --password=$MYSQL_ROOT_PASSWORD --connect-expired-password --execute="GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;" >/dev/null

    echo "stop mysqld_safe mode and start mysqld"
    killall mysqld
    sleep 10
fi

exec "$@"