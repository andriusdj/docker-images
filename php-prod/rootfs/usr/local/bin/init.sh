#!/usr/bin/env bash

if [[ ! -f /.dockerenv ]]; then
  echo -e "ERROR: Not inside Docker environment! Abort!!!"
  exit 1
fi

USER_UID=${USER_UID:-0}
GROUP_GID=${GROUP_GID:-0}

if [[ ${USER_UID} -ne 0 ]] && [[ ${GROUP_GID} -ne 0 ]]; then
  echo "Setting up www-data user..."
  GROUP20="$(cat /etc/group | grep :20: | cut -d':' -f 1)"
  groupdel "${GROUP20}"
  userdel -f www-data
  if getent group www-data; then groupdel www-data; fi
  groupadd -g "${GROUP_GID}" www-data
  useradd -l -u "${USER_UID}" -g www-data www-data
  install -d -m 0755 -o www-data -g www-data /home/www-data
  echo "Done setting up www-data user."
fi

if [[ -f "/etc/php/conf.d/90-php.ini" ]]; then
  echo "Customizing PHP configuration..."
  for VER in /etc/php/*; do
    if [[ -d "${VER}/conf.d" ]]; then
      ln -sv "/etc/php/conf.d/90-php.ini" "${VER}/conf.d/90-php.ini"
      ln -svf "/etc/php/fpm/www.conf" "${VER}/php-fpm.d/www.conf"
    else
      echo " - ${VER} not available."
    fi
  done
  echo "Done customizing PHP configuration."
fi

echo "Setting up PHP CLI binary...";
PHP_BINARIES=( php56 php73 php74 php70 );
PHP="$(command -v php)"
if [[ ! -f "${PHP}" ]]; then
  for PHP_BIN in "${PHP_BINARIES[@]}"; do
    if [[ -f "/bin/${PHP_BIN}" ]]; then
      ln -s "/bin/${PHP_BIN}" "/bin/php"
    fi
  done
fi
echo "DONE: $(command -v php)"

exec /usr/bin/supervisord --configuration /etc/supervisor/supervisord.conf --nodaemon
