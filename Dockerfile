FROM php:5.6.29-apache

RUN docker-php-ext-install pdo_mysql
RUN a2enmod rewrite

ADD . /var/www
ADD ./public /var/www/html