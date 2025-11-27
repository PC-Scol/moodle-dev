#!/bin/bash
# -*- coding: utf-8 mode: sh -*- vim:sw=4:sts=4:et:ai:si:sta:fenc=utf-8
source /config/shared_env || exit 1
source /config/moodle.conf || exit 1

MYDIR="$(cd "$(dirname "$0")"; pwd)"
MYNAME="$(basename "$0")"

function die() {
    echo "ERREUR FATALE: $*" 1>&2
    exit 1
}

# installer les outils nécessaires
syspackages=(
    less
)
apt-get update
apt-get install -y --no-install-recommends "${syspackages[@]}" "${packages[@]}"

# configurer php
eval "inis=($(cd /src/php; ls *.ini 2>/dev/null))"
for ini in "${inis[@]}"; do
    ln -s "/src/php/$ini" "/usr/local/etc/php/conf.d/$ini"
done
ln -sf "/usr/local/etc/php/php.ini-$mode" /usr/local/etc/php/php.ini

for phpext in "${phpexts[@]}"; do
    configure="${phpext}_configure[@]"; configure="${!configure}"
    echo "\
================================================================================
== $phpext ${configure[*]}"
    docker-php-ext-configure "$phpext" "${configure[@]}"
    docker-php-ext-install "$phpext"
done

# installer composer
ln -sf /src/composer/composer.phar /usr/local/bin/composer

# configurer apache
ln -sf /src/apache/000-default.conf /etc/apache2/sites-enabled/000-default.conf
ln -sf /src/apache/ports.conf /etc/apache2/ports.conf

# créer l'utilisateur moodle
useradd -m -u "$USER_UID" -U -d /var/www/moodle moodle

# répertoire de données
mkdir -p /var/www/moodledata
chown moodle: /var/www/moodledata

# moosh
ln -s /opt/moosh/moosh.php /usr/local/bin/moosh

exit 0
