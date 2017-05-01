#FROM wordpress:fpm
FROM wordpress:fpm-alpine

# Pm ondemand to save RAM
RUN sed -i 's/pm = dynamic/pm = ondemand/g' /usr/local/etc/php-fpm.d/www.conf

#RUN apt-get update && apt-get -y install curl unzip
RUN apk add --update curl unzip && rm -Rf /var/cache/apk/*

# Sqlite integration plugin
RUN curl -o /tmp/wpplugin.zip https://downloads.wordpress.org/plugin/sqlite-integration.1.8.1.zip
RUN unzip /tmp/wpplugin.zip -d /usr/src/wordpress/wp-content/plugins/
RUN rm /tmp/wpplugin.zip
# Setup
RUN cp /usr/src/wordpress/wp-content/plugins/sqlite-integration/db.php /usr/src/wordpress/wp-content

COPY config/wp-config.php /var/www/wp-config.php
RUN chown www-data:www-data /var/www/wp-config.php

VOLUME ["/var/www/db"]
