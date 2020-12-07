## Docker for Magento 2
This branch is about Magento 2 software
### Used containers:
    - For web        -> php:7.4-apache
    - For es01       -> docker.elastic.co/elasticsearch/elasticsearch:7.10.0
    - For mysql      -> mariadb:10.4
    - For phpmyadmin -> phpmyadmin
### Created volumes:
    - For mysql -> db-data
    - For es01  -> elasticsearch-data

### Steps:
    1. Clone this repository and select Magent2 branch.
    2. Download Magento 2 software
    3. Change name of Magento and copy in this directory.
    3. Run "docker-compose up --build"
    4. Run commands of commands.txt file into web container. (Those commands will install Magento software.)

License
----
Feli Adrian Mamani Foronda

**Free Software, Hell Yeah!**