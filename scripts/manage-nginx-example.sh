#!/bin/bash
case "$1" in
  start|stop|restart|reload|status|test)
    systemctl "$1" nginx
    ;;
  *)
    echo "Uso: manage-nginx {start|stop|restart|reload|status|test}"
    exit 1
    ;;
esac