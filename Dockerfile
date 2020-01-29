FROM php:7.1.12

RUN set -x \
 && apt-get update -y \
 && apt-get install -y wget apt-transport-https gnupg \
 && apt-get install -y xz-utils libzip-dev libpq-dev libcurl4-gnutls-dev libicu-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev libc-client-dev libkrb5-dev libgconf-2-4 libonig-dev \
 && apt-get install -y git zip \
 && pecl install xdebug \
 && docker-php-ext-configure gd --with-freetype \
 && docker-php-ext-install mbstring curl json intl gd xml zip bz2 opcache pdo_mysql pcntl \
 && export XDEBUG_PATH=`find / -name "xdebug.so"` \
 && echo ";zend_extension=$XDEBUG_PATH" > /usr/local/etc/php/conf.d/xdebug.ini \
 && echo "xdebug.remote_host="`hostname -i` >> /usr/local/etc/php/conf.d/xdebug.ini \
 && echo "date.timezone = Europe/Berlin" > /usr/local/etc/php/conf.d/timezone.ini \
 && echo "memory_limit = -1" > /usr/local/etc/php/conf.d/memory.ini \
 && wget -O /usr/local/bin/composer https://getcomposer.org/download/1.9.2/composer.phar \
 && chmod +x /usr/local/bin/composer \
 && apt-get autoclean -y \
 && apt-get --purge autoremove -y \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && php -i

