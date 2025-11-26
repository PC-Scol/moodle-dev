#!/bin/sh

while true; do
    sleep 60
    wget -q -O - 'http://web:8080/admin/cron.php?password=cron'
done
