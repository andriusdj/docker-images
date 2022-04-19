#!/usr/bin/env bash

source .env

declare -a PHP_VERSIONS=(
  "5.6" # for legacy monster
  "7.4" # for legacy
  "8.0" # currently used v8
  "8.1" # where we should all upgrade to
);

declare -a COMPOSER_VERSIONS=(
  "1" # latest 1.x
  "2" # latest 2.x
)

login()
{
    echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
}

push()
{
    docker push --all-tags "${DOCKER_REPOSITORY}"
}
echo "========================================================================"
echo ""
for PHP_VERSION in "${PHP_VERSIONS[@]}"; do
  for COMPOSER_VERSION in "${COMPOSER_VERSIONS[@]}"; do
      echo "------------------------------------------------------------------------"
      echo " Building PHP v${PHP_VERSION}.x on Debian with composer v${COMPOSER_VERSION}.x"
      echo "------------------------------------------------------------------------"
      docker build -t "${DOCKER_REPOSITORY}:${PHP_VERSION}-${COMPOSER_VERSION}" \
        --build-arg "PHP_VERSION=${PHP_VERSION}" \
        --build-arg "COMPOSER_VERSION=${COMPOSER_VERSION}" \
        . || exit 1
    done
done
echo "Done Building."
echo "========================================================================"
echo ""
echo "------------------------------------------------------------------------"
echo "Pushing images to Docker HUB..."
echo "------------------------------------------------------------------------"
push || (login && push)
echo "Done pushing."
echo "========================================================================"
