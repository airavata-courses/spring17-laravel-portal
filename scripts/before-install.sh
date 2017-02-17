echo 'Cleaning previous laravel directory if any'
sudo rm -rf /home/ec2-user/laravel-portal/ || true

echo 'Creating Laravel Log file'
sudo touch /var/log/laravel.log
sudo chmod 777 /var/log/laravel.log

echo 'Creating destination directory'
sudo mkdir /home/ec2-user/laravel-portal/

echo 'Check if Docker is installed. If not, install it on the instance'
docker -v
if [ "$?" -ne 0 ]; then
	sudo apt-get -y install apt-transport-https ca-certificates
	curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
	sudo apt-get -y install software-properties-common
	sudo add-apt-repository "deb https://apt.dockerproject.org/repo/ ubuntu-$(lsb_release -cs) main"
	sudo apt-get update
	sudo apt-get -y install docker-engine
	sudo service docker start
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