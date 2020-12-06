FROM php:7.4-apache
WORKDIR /var/www/html
ENV PHP_INI_DIR=/usr/local/etc/php
ENV APACHE_CONF_DIR=/etc/apache2
# Apache container rule
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/conf.d/php.ini"
# installing needed software 
RUN apt-get update && apt-get install unzip
# installing PHP requirements
ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync
RUN apt-get update && install-php-extensions bcmath ctype curl dom gd hash iconv intl mbstring openssl pdo_mysql simplexml soap xsl zip sockets
# configuring APACHE and PHP files
RUN sed -i '172 s/None/All/g' $APACHE_CONF_DIR/apache2.conf
RUN sed -i 's/memory_limit = 128M/memory_limit = 2G/' $PHP_INI_DIR/conf.d/php.ini
# copy and unzip Magento 2 in WORKDIR
COPY magento2.4.zip /var/www/html
RUN unzip magento2.4.zip
# writer permits for Apache
RUN a2enmod rewrite
RUN service apache2 restart