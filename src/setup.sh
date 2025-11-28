# -*- coding: utf-8 mode: sh -*- vim:sw=4:sts=4:et:ai:si:sta:fenc=utf-8

set_supportv51

moodlebase=/var/www/moodle
moodleroot="$moodlebase"
if [ -n "$supportv51" ]; then
    moodleroot="$moodleroot/public"
fi
