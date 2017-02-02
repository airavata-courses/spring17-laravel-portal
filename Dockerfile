FROM php:5.6.29-apache

RUN apt-get update && apt-get install -y zlib1g-dev \
    && docker-php-ext-install zip
RUN docker-php-ext-install pdo_mysql
RUN a2enmod rewrite

ADD . /var/www/laravel-develop
ADD ./public /var/www/html
