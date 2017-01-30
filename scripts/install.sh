echo 'Deploying Laravel Portal'
cd /home/ec2-user/

<<<<<<< HEAD
echo 'Run Laravel'
php artisan serve
=======
echo 'Move files to laravel-portal'
sudo mv app composer.json composer.lock gulpfile.js package.json routes tests appspec.yml install phpunit.xml scripts artisan config public server.php bootstrap database LICENSE resources storage laravel-portal/

echo 'Running Docker container'
sudo docker login -e="sneha.tilak26@gmail.com" -u="tilaks" -p="laravel"
sudo docker pull tilaks/laravel-portal
sudo docker images | grep '<none>' | awk '{print $3}' | xargs --no-run-if-empty docker rmi -f
sudo docker run -d -p 8081:8000 --name laravel $(docker images | grep -w "tilaks/laravel-portal" | awk '{print $3}') >> /var/log/laravel.log 2>&1 &
>>>>>>> 9304e72f9975bc06564ac6e1d8ed8f38ab8f619f
