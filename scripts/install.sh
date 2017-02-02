echo 'Deploy the Laravel Portal'
cd /home/ec2-user/

echo 'Move files to laravel-portal'
sudo mv Dockerfile app bootstrap config package.json readme.md scripts tests LICENSE appspec.yml composer.json database phpunit.xml resources server.php Trigger.txt artisan composer.lock gulpfile.js public routes storage .env.example laravel-portal/
cd laravel-portal/
sudo chmod -R 777 /home/ec2-user/laravel-portal/

echo 'Running the Docker container'
sudo docker login -e="sneha.tilak26@gmail.com" -u="tilaks" -p="laravel"
sudo docker pull tilaks/laravel-portal
sudo docker images | grep '<none>' | awk '{print $3}' | xargs --no-run-if-empty docker rmi -f
sudo docker run -p 3000:3000 -p 4000:4000 -p 5000:5000 -d --name laravel $(docker images | grep -w "tilaks/laravel-portal" | awk '{print $3}') >> /var/log/laravel.log 2>&1 &

echo 'Run Laravel Portals inside docker container'
sudo docker exec -it laravel bash

echo 'Change directory to laravel-develop'
cd /var/www/laravel-develop
chmod -R 777 /var/www/laravel-develop

pwd >> /var/log/docker.log 2>&1 &

echo 'Install composer'
composer install

echo 'Copy to .env'
cp .env.example .env

echo 'Change .env permission'
chmod 777 .env

echo 'Generate the Artisan key'
php artisan key:generate

echo 'Run the portals'
php artisan serve --port=3000 --host=0.0.0.0 &
php artisan serve --port=4000 --host=0.0.0.0 &
php artisan serve --port=5000 --host=0.0.0.0 &