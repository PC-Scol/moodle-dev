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

# attendre que mysql est disponible
echo "# attente de mysql"
while true; do
    if mysql -hdb -umoodle -pmoodle -e "select 1" >&/dev/null; then
        break
    fi
    echo "... attente de mysql"
    sleep 1
done

# configurer moodle
if [ ! -d vendor ]; then
    cd /var/www/moodle
    composer i
fi
if [ ! -f config.php ]; then
    echo "# installation de moodle"
    cd /var/www/moodle/admin/cli
    php install.php "${initial_config[@]}"

    echo "# configuration initiale de moodle"
    cd /var/www/moodle/public
    /src/moodle.init
fi

# démarrer apache
echo "# démarrage apache"
cd /var/www/moodle/public
export APACHE_RUN_USER=moodle
export APACHE_RUN_GROUP=moodle
exec /usr/local/bin/apache2-foreground
