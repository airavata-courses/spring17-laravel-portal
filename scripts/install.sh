echo 'Deploying Laravel Portal'
cd /home/ec2-user/

echo 'Move files to laravel-portal'
sudo mv app composer.json composer.lock gulpfile.js package.json routes tests appspec.yml install phpunit.xml scripts artisan config public server.php bootstrap database LICENSE resources storage laravel-portal/

echo 'Run Laravel'
php -S localhost:4000 &