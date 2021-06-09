FROM php:7.4.20-zts-buster

RUN apt-get update -y && \
apt-get upgrade -y && \
apt-get install -y unzip bash git libc-dev rsync sed nodejs npm curl \
libcurl4-openssl-dev libzip-dev libonig-dev libxml2-dev && \
docker-php-ext-install mysqli curl zip mbstring dom xml json && \
cp $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini && \
sed -i -e 's/^short_open_tag\s*=.*/short_open_tag = Off/' $PHP_INI_DIR/php.ini && \
apt-get -y clean && rm -rf /var/lib/apt/lists/*

