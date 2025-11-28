#!/bin/bash
# -*- coding: utf-8 mode: sh -*- vim:sw=4:sts=4:et:ai:si:sta:fenc=utf-8
source /config/shared_env || exit 1
source /src/defaults.sh || exit 1
source /config/moodle.conf || exit 1
source /src/setup.sh || exit 1

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
cd "$moodlebase"
if [ ! -d vendor ]; then
    composer i
fi
if [ ! -f config.php ]; then
    echo "# installation de moodle"
    cd "$moodlebase/admin/cli"
    php install.php "${initial_config[@]}"

    echo "# configuration initiale de moodle"
    cd "$moodleroot"
    /config/moodle.init
fi

# démarrer apache
echo "# démarrage apache"
cd "$moodleroot"
export APACHE_RUN_USER=moodle
export APACHE_RUN_GROUP=moodle
exec /usr/local/bin/apache2-foreground
