FROM php:7.4-apache
ENV PHP_INI_DIR=/usr/local/etc/php
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/conf.d/php.ini"
WORKDIR /var/www/html
ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
RUN apt update && apt upgrade -y && apt install unzip
COPY magento2.4.zip /var/www/html
RUN unzip magento2.4.zip
RUN chmod +x /usr/local/bin/install-php-extensions && sync
RUN install-php-extensions bcmath ctype curl dom gd hash iconv intl mbstring openssl pdo_mysql simplexml soap xsl zip sockets
#RUN service apache2 restart
# RUN apt update && apt install apt-transport-https ca-certificates wget gnupg -y
# RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
# RUN sh -c 'echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" > /etc/apt/sources.list.d/elastic-7.x.list'
# RUN apt update &&  apt install elasticsearch
# RUN service elasticsearch restart
# RUN service elasticsearch start
# RUN curl -X GET "localhost:9200/"
#RUN php bin/magento sampledata:deploy