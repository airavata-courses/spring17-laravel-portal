echo 'Deploying Laravel Portal'
cd /home/ec2-user/

echo 'Move files to laravel-portal'
sudo mv Dockerfile app bootstrap config package.json readme.md scripts tests LICENSE appspec.yml composer.json database phpunit.xml resources server.php Trigger.txt artisan composer.lock gulpfile.js public routes storage .env.example laravel-portal/
cd laravel-portal/
composer install
cp .env.example .env
php artisan key:generate
php artisan serve --port=8000 --host=0.0.0.0

echo 'Running Docker container'
sudo docker login -e="sneha.tilak26@gmail.com" -u="tilaks" -p="laravel"
sudo docker pull tilaks/laravel-portal
sudo docker images | grep '<none>' | awk '{print $3}' | xargs --no-run-if-empty docker rmi -f
sudo docker run -d -p 8081:8000 --name laravel $(docker images | grep -w "tilaks/laravel-portal" | awk '{print $3}') >> /var/log/laravel.log 2>&1 &
