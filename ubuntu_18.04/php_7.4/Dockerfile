FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    locales \
    tzdata \
    curl

RUN locale-gen en_US.UTF-8 && \
    ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN export LANG=en_US.UTF-8 && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C && \
    apt-get install -y \
    php7.4-fpm \
    php7.4-cli

RUN apt-get install -y \
    php7.4-dev \
    php7.4-mbstring \
    php7.4-bcmath \
    php7.4-tokenizer \
    php7.4-ctype \
    php7.4-json \
    php7.4-curl \
    php7.4-zip \
    php7.4-xml \
    php7.4-mysql \
    php7.4-pgsql \
    php7.4-sqlite3 \
    php7.4-gd \
    php7.4-imagick \
    php7.4-intl

RUN mkdir /run/php && \
    sed -i '/listen = \/run\/php\/php7.4-fpm.sock/s/^/;/g' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i '/;listen = \/run\/php\/php7.4-fpm.sock/a listen = 0.0.0.0:9000\n' /etc/php/7.4/fpm/pool.d/www.conf

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    composer

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]