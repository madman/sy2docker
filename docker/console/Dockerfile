FROM alpine:3.4

MAINTAINER Yuriy Prokopets <yuriy.prokopets@gmail.com>

# Environments
ENV TIMEZONE            Europe/Kiev
ENV PHP_MEMORY_LIMIT    64M
ENV MAX_UPLOAD          5M
ENV PHP_MAX_FILE_UPLOAD 5
ENV PHP_MAX_POST        25M

# Let's roll
RUN	apk update && \
	apk upgrade && \
	apk add --update tzdata && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	apk add --update \
                curl \ 
                php5-ctype \
                php5-phar \
		        php5-memcache \
		        php5-zip \
		        php5-bz2 \
                php5-curl \
                php5-gd \
                php5-iconv \
                php5-imagick \
                php5-json \
                php5-intl \
                php5-mcrypt \
                php5-mysql \
                php5-opcache \
                php5-openssl \
                php5-pdo \
                php5-pdo_mysql \
                php5-mysqli \
                php5-xml \
                php5-dom \
                php5-zlib \
                php5-cli

RUN \
    echo 'export SYMFONY__DATABASE__HOST=$MYSQL_PORT_3306_TCP_ADDR' >> /root/.profile && \
    echo 'export SYMFONY__DATABASE__PORT=$MYSQL_PORT_3306_TCP_PORT' >> /root/.profile && \
    echo 'export SYMFONY__DATABASE__NAME=$MYSQL_1_ENV_MYSQL_DATABASE' >> /root/.profile && \
    echo 'export SYMFONY__DATABASE__USER=$MYSQL_1_ENV_MYSQL_USER' >> /root/.profile && \
    echo 'export SYMFONY__DATABASE__PASSWORD=$MYSQL_1_ENV_MYSQL_PASSWORD' >> /root/.profile

RUN rm -rf /var/cache/apk/* && rm -rf /tmp/*

WORKDIR /data/www/site/bin

RUN set -x \
	&& addgroup -g 82 -S www-data \
	&& adduser -u 1001 -D -S -G www-data www-data

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh 
RUN ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

CMD ["-"]
ENTRYPOINT ["/entrypoint.sh"]