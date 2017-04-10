FROM alpine:3.4
#see https://github.com/RobLoach/docker-composer/blob/master/base/php5-alpine/Dockerfile

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
RUN apk add php5-cli php5-posix git openssh


###############
RUN rm -rf /var/cache/apk/* && rm -rf /tmp/*


# Register the COMPOSER_HOME environment variable
ENV COMPOSER_HOME /composer

# Add global binary directory to PATH and make sure to re-export it
ENV PATH /composer/vendor/bin:$PATH

# Memory Limit
ENV PHP_MEMORY_LIMIT    1024M
RUN sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php5/php.ini

# Setup the Composer installer
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
  && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
  && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }"

# Install Composer
ENV COMPOSER_VERSION 1.2.0
RUN php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} && rm -rf /tmp/composer-setup.php

# Display version information.
RUN composer --version

RUN chown -R www-data:www-data /composer/cache

WORKDIR /data/www/site

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh 
RUN ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

USER www-data

CMD ["-V"]
ENTRYPOINT ["/entrypoint.sh"]