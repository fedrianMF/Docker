## Docker for Magento 2
This branch is for Magento 2 software
### Used containers:
    *For web -> php:7.4-apache
    *For es01 -> docker.elastic.co/elasticsearch/elasticsearch:7.10.0
    *For mysql -> mariadb:10.4
    *For phpmyadmin -> phpmyadmin
### Created volumes:
    *For mysql -> db-data
    *For es01 -> elasticsearch-data

commands.txt file: that document it used after run "docker-compose up --build"
