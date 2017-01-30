echo 'Deploying Laravel Portal'
cd /home/ec2-user/

echo 'Move files to laravel-portal'
sudo mv Dockerfile app bootstrap config package.json readme.md scripts tests LICENSE appspec.yml composer.json database phpunit.xml resources server.php Trigger.txt artisan composer.lock gulpfile.js public routes storage .env.example laravel-portal/
cd laravel-portal/
cp .env.example .env
sudo chmod 777 -R storage/
sudo chmod 777 .env
echo 'Logs begin here...' >> /var/log/composer.log 2>&1 &
pwd >> /var/log/composer.log 2>&1 &
composer install >> /var/log/composer.log 2>&1 &
php artisan key:generate >> /var/log/composer.log 2>&1 &
php artisan serve --port=4000 --host=0.0.0.0 & >> /var/log/composer.log 2>&1 &

echo 'Running Docker container'
sudo docker login -e="sneha.tilak26@gmail.com" -u="tilaks" -p="laravel"
sudo docker pull tilaks/laravel-portal
sudo docker images | grep '<none>' | awk '{print $3}' | xargs --no-run-if-empty docker rmi -f
sudo docker run -d -p 4000:8000 --name laravel $(docker images | grep -w "tilaks/laravel-portal" | awk '{print $3}') >> /var/log/laravel.log 2>&1 &
