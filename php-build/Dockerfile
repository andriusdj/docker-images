ARG PHP_VERSION
ARG COMPOSER_VERSION

FROM composer:${COMPOSER_VERSION} AS composerVersion

FROM earthian/php-prod:${PHP_VERSION} AS base
ENV LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive
COPY rootfs /
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - ;\
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - ;\
    apt-get update && apt-get upgrade -y &&  \
    apt-get install -y nodejs yarn &&  \
    apt-get clean && apt-get autoclean;

COPY --from=composerVersion /usr/bin/composer /usr/local/bin/composer

CMD ["/usr/local/bin/init.sh"]
