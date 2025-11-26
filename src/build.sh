#!/bin/bash
# -*- coding: utf-8 mode: sh -*- vim:sw=4:sts=4:et:ai:si:sta:fenc=utf-8
source /src/shared_env || exit 1
source /src/moodle.conf || exit 1

MYDIR="$(cd "$(dirname "$0")"; pwd)"
MYNAME="$(basename "$0")"

function die() {
    echo "ERREUR FATALE: $*" 1>&2
    exit 1
}

# installer les outils nécessaires
syspackages=(
    less
    cron
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
useradd -m -u 1000 -U -d /var/www/moodle moodle

# installer moosh
eval "files=($(ls /src/install/moosh_*.zip 2>/dev/null))"
[ ${#files[*]} -gt 0 ] || die "Impossible de trouver l'archive moosh"

unzip "${files[0]}" -d /opt
chown -R moodle: /opt/moosh
ln -s /opt/moosh/moosh.php /usr/local/bin/moosh

# répertoire de données
mkdir -p /var/www/moodledata
chown -R moodle: /var/www/moodledata

# installer moodle
eval "files=($(ls /src/install/moodle-*.tgz 2>/dev/null))"
[ ${#files[*]} -gt 0 ] || die "Impossible de trouver l'archive moodle"

tar xzf "${files[0]}" -C /var/www
chown -R moodle: /var/www/moodle

exit 0
