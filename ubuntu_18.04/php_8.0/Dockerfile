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
    php8.0-fpm \
    php8.0-cli

RUN apt-get install -y --no-install-recommends \
    php8.0-dev \
    php8.0-mbstring \
    php8.0-bcmath \
    php8.0-tokenizer \
    php8.0-ctype \
    php8.0-curl \
    php8.0-zip \
    php8.0-xml \
    php8.0-mysql \
    php8.0-pgsql \
    php8.0-sqlite3 \
    php8.0-gd \
    php8.0-imagick \
    php8.0-intl

RUN mkdir /run/php && \
    sed -i '/listen = \/run\/php\/php8.0-fpm.sock/s/^/;/g' /etc/php/8.0/fpm/pool.d/www.conf && \
    sed -i '/;listen = \/run\/php\/php8.0-fpm.sock/a listen = 0.0.0.0:9000\n' /etc/php/8.0/fpm/pool.d/www.conf

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    composer

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 9000

CMD ["/usr/sbin/php-fpm8.0", "-F"]
