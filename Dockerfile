FROM php:7.4-apache
WORKDIR /var/www/html
ENV PHP_INI_DIR=/usr/local/etc/php
ENV APACHE_CONF_DIR=/etc/apache2
# Apache delelopment mode
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/conf.d/php.ini"
# needed software
RUN apt-get update && apt-get install -y unzip zlib1g-dev \
    libpng-dev libicu-dev libxml2-dev libxslt-dev libzip-dev \
    libjpeg-dev libfreetype6-dev
# PHP requirements (ctype, curl, dom, hash, iconv, mbstring, openssl, simplexml. already installed)
RUN docker-php-ext-install bcmath intl pdo_mysql soap xsl zip sockets \
    && docker-php-ext-configure gd --with-jpeg && docker-php-ext-install gd
# PHP configuration
RUN sed -i 's/memory_limit = 128M/memory_limit = 2G/' $PHP_INI_DIR/conf.d/php.ini
RUN sed -i 's/;date.timezone =/date.timezone = America\/La_Paz/' $PHP_INI_DIR/conf.d/php.ini
RUN sed -i 's/;realpath_cache_size = 4096k/realpath_cache_size = 10M/' $PHP_INI_DIR/conf.d/php.ini
RUN sed -i 's/;realpath_cache_ttl = 120/realpath_cache_ttl = 7200/' $PHP_INI_DIR/conf.d/php.ini
RUN sed -i 's/;opcache.save_comments=1/opcache.save_comments=1/' $PHP_INI_DIR/conf.d/php.ini
# Apache writer permits
RUN sed -i '13i\\t<Directory \"/var\/www\/html">\n\t\tAllowOverride All\n\t<\/Directory>' $APACHE_CONF_DIR/sites-enabled/000-default.conf
RUN sed -i '16i\\tAllowEncodedSlashes NoDecode' $APACHE_CONF_DIR/sites-enabled/000-default.conf
RUN a2enmod rewrite
RUN service apache2 restart
# copy and unzip Magento 2 in WORKDIR
COPY magento2.4.zip /var/www/html
RUN unzip magento2.4.zip && rm magento2.4.zip