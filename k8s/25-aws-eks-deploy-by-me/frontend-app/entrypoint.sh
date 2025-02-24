#!/usr/bin/bash

#sed -i "s@BACKEND_API_BASE_URL@$BACKEND_API_BASE_URL@g" /usr/share/nginx/html/static/js/main.*.js
sed -i "s@_BACKEND_API_BASE_URL_@$BACKEND_API_BASE_URL@g" /usr/share/nginx/html/requests.js

exec "$@"