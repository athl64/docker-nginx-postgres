#!/bin/bash

set -e

chown -R www-data:www-data /web /var/log/php

service postgresql start

exec /usr/bin/supervisord --nodaemon -c /etc/supervisor/supervisord.conf
