#!/usr/bin/env sh

sed -i "s/DOMAIN/$DOMAIN/g" ./hugface/keepalive.sh

exec supervisord -c ./hugface/supervisord.conf

exec "$@"
