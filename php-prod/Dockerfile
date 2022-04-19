FROM debian:11-slim

ARG PHP_VERSION
ENV LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive PHP_VERSION=${PHP_VERSION}

RUN apt-get update && apt-get upgrade -y && apt-get install \
        apt-utils apt-transport-https ca-certificates \
        curl gnupg2 supervisor wkhtmltopdf jpegoptim pngquant -y \
    && apt-get clean && apt-get autoclean

COPY rootfs /

RUN curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add - ;\
    curl -fsSL https://packages.sury.org/php/apt.gpg | apt-key add - ;\
    apt-get update && apt-get upgrade -y && apt-get install -y nginx \
        php${PHP_VERSION}-bcmath \
        php${PHP_VERSION}-calendar \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-exif \
        php${PHP_VERSION}-fpm \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-iconv \
        php${PHP_VERSION}-intl \
        php${PHP_VERSION}-ldap \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-mcrypt \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-mysqli \
        php${PHP_VERSION}-pgsql \
        php${PHP_VERSION}-soap \
        php${PHP_VERSION}-sqlite3 \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-zip \
        php${PHP_VERSION}-amqp \
        php${PHP_VERSION}-imagick \
        php${PHP_VERSION}-apcu \
        php${PHP_VERSION}-memcache \
        php${PHP_VERSION}-memcached \
        php${PHP_VERSION}-redis \
    && apt-get clean && apt-get autoclean

CMD ["/usr/local/bin/init.sh"]
