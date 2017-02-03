echo 'Cleaning previous laravel directory if any'
sudo rm -rf /home/ec2-user/laravel-portal/ || true

echo 'Creating Laravel Log file'
sudo touch /var/log/laravel.log
sudo chmod 777 /var/log/laravel.log

echo 'Creating destination directory'
sudo mkdir /home/ec2-user/laravel-portal/

echo 'Check if PHP is installed. If not, install it on the instance'
php --version
if [ "$?" -ne 0 ]; then
	sudo yum clean all
	sudo yum -y update
	sudo yum install -y httpd24 php56
	sudo yum install -y php56-devel php56-mysql php56-pdo php56-mbstring
	sudo yum install -y php-pear
	sudo pear install Log
	sudo yum install -y pcre-devel
	sudo service httpd start
	sudo yum install -y php56-pecl-apc
	sudo /sbin/chkconfig --levels 235 httpd on
	sudo service httpd restart
	sudo yum -y update
fi

echo 'Check if Composer is installed. If not, install it on the instance'
composer --version
if [ "$?" -ne 0 ]; then
	cd ~/
	curl -sS https://getcomposer.org/installer | php
	sudo mv composer.phar /usr/local/bin/composer
	chmod +x /usr/local/bin/composer
	sudo ln -s /usr/local/bin/composer /usr/bin/composer
	sudo alias composer='/usr/local/bin/composer'
fi

echo 'Check if Docker is installed. If not, install it on the instance'
docker -v
if [ "$?" -ne 0 ]; then
	sudo yum install -y docker-io
fi

echo 'Add current user to Docker group'
sudo usermod -aG docker $(whoami)

echo 'Start Docker services'
sudo service docker start

echo 'Remove existing containers if any'
sudo docker ps -a | grep -w "laravel" | awk '{print $1}' | xargs --no-run-if-empty docker stop
sudo docker ps -a | grep -w "laravel" | awk '{print $1}' | xargs --no-run-if-empty docker rm

echo 'Remove existing images if any'
sudo docker images | grep -w "tilaks/laravel-portal" | awk '{print $3}' | xargs --no-run-if-empty docker rmi -f