#!/bin/bash

PORT=$1
echo $PORT

echo 'Run the portals'
php -S 0.0.0.0:$PORT server.php >> /var/log/script-$PORT.log