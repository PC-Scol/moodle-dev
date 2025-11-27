# -*- coding: utf-8 mode: dockerfile -*- vim:sw=4:sts=4:et:ai:si:sta:fenc=utf-8
FROM php:8.2-apache

USER root
COPY src/ /src/
COPY config/ /config/
RUN /src/build.sh

EXPOSE 8080
USER moodle
WORKDIR /var/www/moodle/public
ENTRYPOINT ["/src/entrypoint.sh"]
