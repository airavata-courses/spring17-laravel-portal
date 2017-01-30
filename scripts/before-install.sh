echo 'Cleaning previous laravel directory if any'
sudo rm -fd /home/ec2-user/laravel-portal/ || true

echo 'Creating destination directory'
sudo mkdir /home/ec2-user/laravel-portal/

echo 'Update OS'
sudo yum -y update

echo 'Change directory'
cd /home/ec2-user/laravel-portal/

echo 'Check if PHP is installed'
php --version
if [ "$?" -ne 0 ]; then
	sudo yum clean all
	sudo yum -y update
	sudo yum -y install epel-release
	wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
	wget https://centos6.iuscommunity.org/ius-release.rpm
	sudo rpm -Uvh ius-release*.rpm
	sudo yum -y update
	sudo yum -y install php56u php56u-opcache php56u-xml php56u-mcrypt php56u-gd php56u-devel php56u-mysql php56u-intl php56u-mbstring php56u-bcmath
fi

echo 'Check if Laravel is installed'
cd /var/www/laravel-develop/
if [ "$?" -ne 0 ]; then
	curl -sS https://getcomposer.org/installer | php
	sudo mv composer.phar /usr/local/bin/composer
	chmod +x /usr/local/bin/composer
	wget https://github.com/laravel/laravel/archive/develop.zip
	unzip develop.zip
	mv laravel-develop /var/www/
	sudo rm -rf develop.zip
	cd /var/www/laravel-develop/
fi

echo 'Update Composer'
composer update

echo 'Move back to ec2-user directory'
cd /home/ec2-user/laravel-portal/

echo 'Check if Docker is installed'
docker -v
if [ "$?" -ne 0 ]; then
	sudo yum install -y docker-io
fi

echo 'Add current user to Docker group'
sudo usermod -aG docker $(whoami)

echo 'Starting Docker services'
sudo service docker start
	
echo 'Remove existing containers if any'
sudo docker ps -a | grep -w "laravel" | awk '{print $1}' | xargs --no-run-if-empty docker stop
sudo docker ps -a | grep -w "laravel" | awk '{print $1}' | xargs --no-run-if-empty docker rm

echo 'Remove existing images if any'
sudo docker images | grep -w "tilaks/laravel-portal" | awk '{print $3}' | xargs --no-run-if-empty docker rmi -f