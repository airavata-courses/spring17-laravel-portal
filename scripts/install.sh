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
sudo docker run -p 3000:3000 -p 4000:4000 -p 5000:5000 -d --name laravel tilaks/laravel-portal >> /var/log/laravel.log 2>&1

sudo docker exec -it laravel bash /var/www/laravel-develop/composer_install.sh
sudo docker exec -it -d laravel bash /var/www/laravel-develop/script.sh 3000
sudo docker exec -it -d laravel bash /var/www/laravel-develop/script.sh 4000
sudo docker exec -it -d laravel bash /var/www/laravel-develop/script.sh 5000