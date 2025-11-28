# -*- coding: utf-8 mode: sh -*- vim:sw=4:sts=4:et:ai:si:sta:fenc=utf-8

MYDIR="$(cd "$(dirname "$0")"; pwd)"
MYNAME="$(basename "$0")"

function die() {
    [ $# -gt 0 ] && echo "ERREUR FATALE: $*" 1>&2
    exit 1
}

moodlebase=/var/www/moodle
moodleroot="$moodlebase"
if [ -n "$supportv51" ]; then
    moodleroot="$moodleroot/public"
fi
