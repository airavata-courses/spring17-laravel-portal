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