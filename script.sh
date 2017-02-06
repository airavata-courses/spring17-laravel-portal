#!/bin/bash

PORT=$1
echo $PORT

echo 'Run the portals'
php artisan serve --host=0.0.0.0 --port=$PORT >> /var/log/script-$PORT.log