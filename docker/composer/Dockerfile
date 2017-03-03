FROM composer/composer:php5-alpine

MAINTAINER Yuriy Prokopets <yuriy.prokopets@gmail.com>

WORKDIR /data/www/site

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh 
RUN ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

RUN chown -R www-data:www-data /composer/cache

USER www-data

ENTRYPOINT ["/entrypoint.sh"]