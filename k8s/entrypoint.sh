#!/usr/bin/bash

sed -i "s/_hostname_/$(hostname)/g" /usr/share/nginx/html/index.html
sed -i "s/_launch_/$(date)/g" /usr/share/nginx/html/index.html

exec "$@"