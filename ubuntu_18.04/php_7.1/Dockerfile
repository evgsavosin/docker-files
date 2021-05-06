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
    php7.1-fpm \
    php7.1-cli

RUN apt-get install -y \
    php7.1-dev \
    php7.1-mbstring \
    php7.1-bcmath \
    php7.1-tokenizer \
    php7.1-ctype \
    php7.1-json \
    php7.1-curl \
    php7.1-zip \
    php7.1-xml \
    php7.1-mysql \
    php7.1-pgsql \
    php7.1-sqlite3 \
    php7.1-gd \
    php7.1-imagick \
    php7.1-intl \
    php7.1-phalcon

RUN mkdir /run/php && \
    sed -i '/listen = \/run\/php\/php7.1-fpm.sock/s/^/;/g' /etc/php/7.1/fpm/pool.d/www.conf && \
    sed -i '/;listen = \/run\/php\/php7.1-fpm.sock/a listen = 0.0.0.0:9000\n' /etc/php/7.1/fpm/pool.d/www.conf

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    composer

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.1", "-F"]
