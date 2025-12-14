#!/usr/bin/env sh

sed -i "s/DOMAIN/$DOMAIN/g" /app/hugface/keepalive.sh

exec supervisord -c /app/hugface/supervisord.conf

exec "$@"
