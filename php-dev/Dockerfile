ARG PHP_VERSION
ARG COMPOSER_VERSION

FROM earthian/php-build:${PHP_VERSION}-${COMPOSER_VERSION} AS base

ENV LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install \
        apt-utils apt-transport-https \
        lsb-release ca-certificates \
        rsync curl wget gnupg2 dirmngr build-essential supervisor \
        git nano ssh mc net-tools \
        default-mysql-client redis-tools wkhtmltopdf jpegoptim pngquant inetutils-ping bind9-host -y \
    && apt-get clean && apt-get autoclean

COPY rootfs /

RUN apt-get update && apt-get upgrade -y && apt-get install -y nodejs yarn nginx \
        php${PHP_VERSION}-xdebug \
    && apt-get clean && apt-get autoclean

RUN mkdir -p /usr/local/lib/phabricator && \
    git clone https://github.com/phacility/arcanist.git /usr/local/lib/phabricator/arcanist

CMD ["/usr/local/bin/init.sh"]
