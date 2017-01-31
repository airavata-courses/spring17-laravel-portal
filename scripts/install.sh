echo 'Deploy the Laravel Portal'
cd /home/ec2-user/

echo 'Move files to laravel-portal'
sudo mv Dockerfile app bootstrap config package.json readme.md scripts tests LICENSE appspec.yml composer.json database phpunit.xml resources server.php Trigger.txt artisan composer.lock gulpfile.js public routes storage .env.example laravel-portal/
cd laravel-portal/
sudo chmod -R 777 /home/ec2-user/laravel-portal/
cp .env.example .env

echo 'Install Composer to generate vendor packages'
composer install >> /var/log/composer.log 2>&1 &
sudo chmod -R 777 /home/ec2-user/laravel-portal/

echo 'Generate the Artisan key'
php artisan key:generate

echo 'Run the Laravel Portal'
php artisan serve --port=3000 --host=0.0.0.0 & >> /var/log/composer.log 2>&1 &
php artisan serve --port=4000 --host=0.0.0.0 & >> /var/log/composer.log 2>&1 &
php artisan serve --port=5000 --host=0.0.0.0 & >> /var/log/composer.log 2>&1 &

echo 'Running the Docker container'
sudo docker login -e="sneha.tilak26@gmail.com" -u="tilaks" -p="laravel"
sudo docker pull tilaks/laravel-portal
sudo docker images | grep '<none>' | awk '{print $3}' | xargs --no-run-if-empty docker rmi -f
sudo docker run -d --name laravel $(docker images | grep -w "tilaks/laravel-portal" | awk '{print $3}') >> /var/log/laravel.log 2>&1 &
