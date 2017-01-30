FROM php:5.6.29-apache

COPY laravel-develop/ /var/www/laravel-develop/

EXPOSE 8000
EXPOSE 8081