FROM jarzamendia/alpine-3.10

RUN apk add --no-cache dumb-init && \
  ln -sv /usr/bin/dumb-init /bin/dumb-init

RUN apk add --no-cache ca-certificates \
    nginx mysql-client libssh2 curl libpng \
    freetype libjpeg-turbo libgcc libxml2 \
    libstdc++ icu-libs libltdl libmcrypt msmtp

RUN apk add --no-cache php7 php7-common \
                       php7-fpm php7-json \
                       php7-zlib php7-xml \
                       php7-pdo php7-phar \
                       php7-openssl php7-pdo_mysql \
                       php7-mysqli php7-gd \
                       php7-curl php7-opcache \
                       php7-ctype php7-intl \
                       php7-bcmath php7-dom \
                       php7-xmlreader php7-pear \
                       php7-mysqlnd php7-apcu \
                       php7-mbstring php7-fileinfo \
                       php7-session php7-ldap \
                       php7-iconv php7-zip

RUN ln -sf /dev/stdout /var/log/php-fpm.log;

WORKDIR /the/workdir/path
COPY www /srv/www

RUN chown -R nobody:nobody /srv/www; \
    chmod -R 777 /srv/www;

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/php-fpm.conf /etc/php/
COPY conf/php.ini /etc/php/
COPY run.sh /run.sh

ENTRYPOINT ["/usr/bin/dumb-init", "-v", "--"]

VOLUME [ "/srv/www" ]
EXPOSE 80

CMD /bin/sh /run.sh