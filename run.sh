#!/usr/bin/dumb-init /bin/sh
touch /var/log/php-fpm.log
touch /var/log/php-fpm-access.log
php-fpm7 --fpm-config "/etc/php/php-fpm.conf" &
sed -i "s|50|$MAX_PHP_PROCESS|" /etc/php/php-fpm.conf  
nginx