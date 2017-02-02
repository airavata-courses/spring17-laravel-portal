FROM php:5.6.29-apache

RUN apt-get update && apt-get install -y zlib1g-dev \
    && docker-php-ext-install zip
RUN docker-php-ext-install pdo_mysql
RUN a2enmod rewrite

ADD . /var/www
ADD ./public /var/www/html

RUN pwd
RUN cd ../
RUN composer install
RUN php artisan key:generate
RUN php artisan serve --port=3000 --host=0.0.0.0 & >> /var/log/laravel1.log 2>&1 &
RUN php artisan serve --port=4000 --host=0.0.0.0 & >> /var/log/laravel1.log 2>&1 &
RUN php artisan serve --port=5000 --host=0.0.0.0 & >> /var/log/laravel1.log 2>&1 &