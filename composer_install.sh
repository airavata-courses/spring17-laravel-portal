#!/bin/bash

echo 'Change directory'
cd /var/www/laravel-develop

echo 'Install composer'
composer install

echo 'Copy to .env'
cp .env.example .env

echo 'Change .env permission'
chmod 777 .env

echo 'Generate the Artisan key'
php artisan config:clear
php artisan key:generate