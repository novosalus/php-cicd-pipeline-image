FROM php:7.4.20-zts-buster

RUN apt-get update -y && \
apt-get upgrade -y && \
apt-get install -y unzip bash git libc-dev rsync sed curl \
libcurl4-openssl-dev libzip-dev libonig-dev libxml2-dev \
libfreetype6-dev libjpeg62-turbo-dev libpng-dev && \
#required for gd extension
docker-php-ext-install mysqli curl zip mbstring dom xml json && \
docker-php-ext-configure gd --with-freetype --with-jpeg && \
docker-php-ext-install gd && \
curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
apt-get install -y nodejs build-essential && \
cp $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini && \
sed -i -e 's/^short_open_tag\s*=.*/short_open_tag = Off/' $PHP_INI_DIR/php.ini && \
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
php composer-setup.php && \
php -r "unlink('composer-setup.php');" && \
mv composer.phar /usr/local/bin/composer && \
apt-get -y clean && rm -rf /var/lib/apt/lists/*
