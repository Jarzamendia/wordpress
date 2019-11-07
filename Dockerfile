FROM jarzamendia/alpine-3.10

RUN apk add --no-cache tini nginx mysql-client \
            libssh2 curl libpng freetype libjpeg-turbo \
            libgcc libxml2 libstdc++ icu-libs libltdl \
            libmcrypt msmtp \
            \
            php7 php7-common php7-fpm php7-json php7-zlib \
            php7-xml php7-pdo php7-phar php7-openssl \
            php7-pdo_mysql php7-mysqli php7-gd php7-curl \
            php7-opcache php7-ctype php7-intl php7-bcmath \
            php7-dom php7-xmlreader php7-pear php7-mysqlnd \
            php7-apcu php7-mbstring php7-fileinfo php7-session \
            php7-ldap php7-iconv php7-zip && \
    ln -sf /dev/stdout /var/log/php-fpm.log;

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/php-fpm.conf /etc/php/
COPY conf/php.ini /etc/php/
COPY run.sh /run.sh

VOLUME [ "/srv/www" ]

EXPOSE 80

ENV MAX_PHP_PROCESS="30"

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/bin/sh", "/run.sh"]

ARG BUILD_DATE

LABEL org.label-schema.version="1"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="Wordpress"
LABEL org.label-schema.vendor="Wordpress"
LABEL org.label-schema.description="Wordpress, um CMS. Nginx e PHP-FPM incluso!"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.url="https://wordpress.org/"
LABEL org.label-schema.vcs-url="https://github.com/Jarzamendia/wordpress"