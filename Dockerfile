FROM php:7.4-apache
ENV PHP_INI_DIR=/usr/local/etc/php
COPY php.ini /usr/local/etc/php/conf.d/php.ini
COPY apache2.conf /etc/apache2/apache2.conf
WORKDIR /var/www/html
ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
RUN apt update && apt install unzip
COPY magento2.4.zip /var/www/html
RUN unzip magento2.4.zip
RUN chmod +x /usr/local/bin/install-php-extensions && sync
RUN install-php-extensions bcmath ctype curl dom gd hash iconv intl mbstring openssl pdo_mysql simplexml soap xsl zip sockets
RUN a2enmod rewrite
RUN service apache2 restart