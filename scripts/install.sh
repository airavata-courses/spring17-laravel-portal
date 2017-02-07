echo 'Deploy the Laravel Portal'
cd /home/ec2-user/

echo 'Move files to laravel-portal'
sudo mv Dockerfile app bootstrap config package.json readme.md scripts tests LICENSE appspec.yml composer.json database phpunit.xml resources server.php script.sh Trigger.txt artisan composer.lock gulpfile.js public routes storage .env.example composer_install.sh laravel-portal/
cd laravel-portal/
sudo chmod -R 777 /home/ec2-user/laravel-portal/

echo 'Running the Docker container'
sudo docker login -e="sneha.tilak26@gmail.com" -u="tilaks" -p="laravel"
sudo docker pull tilaks/laravel-portal
sudo docker images | grep '<none>' | awk '{print $3}' | xargs --no-run-if-empty docker rmi -f
sudo docker run -d --name laravel tilaks/laravel-portal 

sudo docker exec -it laravel bash /var/www/laravel-develop/composer_install.sh
sudo docker exec -it -d laravel php /var/www/laravel-develop/artisan serve --port=3000 --host=0.0.0.0
sudo docker exec -it -d laravel php /var/www/laravel-develop/artisan serve --port=4000 --host=0.0.0.0
sudo docker exec -it -d laravel php /var/www/laravel-develop/artisan serve --port=5000 --host=0.0.0.0