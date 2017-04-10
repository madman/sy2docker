FROM alpine:3.4

MAINTAINER Yuriy Prokopets <yuriy.prokopets@gmail.com>

# Environments
ENV TIMEZONE            Europe/Kiev

RUN set -x \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data

# Let's roll
RUN apk update && \
    apk upgrade && \
    apk add --update tzdata && \
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    apk add --update \
                curl \ 
                wget \
                ca-certificates \
                php5-ctype \
                php5-phar \
                php5-zip \
                php5-bz2 \
                php5-apcu \
                php5-curl \
                php5-gd \
                php5-iconv \
                php5-imagick \
                php5-json \
                php5-intl \
                php5-mcrypt \
                php5-opcache \
                php5-openssl \
                php5-pdo \
                php5-pdo_mysql \
                php5-mysqli \
                php5-xml \
                php5-dom \
                php5-zlib

#memcached
RUN \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-php5-memcached/master/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-php5-memcached/releases/download/2.2.0-r0/php5-memcached-2.2.0-r0.apk && \
    apk add php5-memcached-2.2.0-r0.apk    

RUN sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php5/php.ini
###############

ENV PHP_MEMORY_LIMIT    64M
ENV MAX_UPLOAD          5M
ENV PHP_MAX_FILE_UPLOAD 5
ENV PHP_MAX_POST        25M

# 
RUN apk add --update php5-fpm 

# 
RUN \
    sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php5/php-fpm.conf && \
    sed -i "s|;*listen\s*=\s*127.0.0.1:9000|listen = 9000|g" /etc/php5/php-fpm.conf && \
    sed -i "s|;*listen\s*=\s*/||g" /etc/php5/php-fpm.conf && \
    sed -i -e "s/user = nobody/user = www-data/g" /etc/php5/php-fpm.conf && \
    sed -i -e "s/group = nobody/group = www-data/g" /etc/php5/php-fpm.conf && \
    sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php5/php.ini && \
    sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php5/php.ini && \
    sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php5/php.ini && \
    sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php5/php.ini && \
    sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php5/php.ini

RUN \
    echo 'env[SYMFONY__DATABASE__HOST] = $MYSQL_PORT_3306_TCP_ADDR' >> /etc/php5/php-fpm.conf && \
    echo 'env[SYMFONY__DATABASE__PORT] = $MYSQL_PORT_3306_TCP_PORT' >> /etc/php5/php-fpm.conf && \
    echo 'env[SYMFONY__DATABASE__NAME] = $MYSQL_1_ENV_MYSQL_DATABASE' >> /etc/php5/php-fpm.conf && \
    echo 'env[SYMFONY__DATABASE__USER] = $MYSQL_1_ENV_MYSQL_USER' >> /etc/php5/php-fpm.conf && \
    echo 'env[SYMFONY__DATABASE__PASSWORD] = $MYSQL_1_ENV_MYSQL_PASSWORD' >> /etc/php5/php-fpm.conf

RUN rm -rf /var/cache/apk/* && rm -rf /tmp/*

WORKDIR /data/www/site

EXPOSE 9000

CMD ["php-fpm", "-F"]