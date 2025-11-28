# -*- coding: utf-8 mode: sh -*- vim:sw=4:sts=4:et:ai:si:sta:fenc=utf-8

: ${HOST:=localhost} ${PORT:=8080}
: ${USER_UID:=1000}

moodledata=/var/www/moodledata

MYDIR="$(cd "$(dirname "$0")"; pwd)"
MYNAME="$(basename "$0")"

function die() {
    [ $# -gt 0 ] && echo "ERREUR FATALE: $*" 1>&2
    exit 1
}

function set_supportv51() {
    [ "$set_supportv51" != none ] && supportv51="$set_supportv51"
    [ "$supportv51" == auto ] || return
    case "$1" in
    moodle-latest-4*) supportv51=;;
    moodle-latest-500*) supportv51=;;
    *) supportv51=1;;
    esac
}
