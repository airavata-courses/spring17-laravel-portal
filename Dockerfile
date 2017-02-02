FROM php:5.6.29-apache

#Install the dependencies
RUN apt-get update && apt-get install -y zlib1g-dev \
    && docker-php-ext-install zip \
	&& apt-get install -y curl nano && \
	curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer && \
	chmod +x /usr/local/bin/composer && \
	ln -s /usr/local/bin/composer /usr/bin/composer && \
	alias composer='/usr/local/bin/composer' && \
	docker-php-ext-install pdo_mysql && \
	a2enmod rewrite

ADD . /var/www/laravel-develop
ADD ./public /var/www/html

RUN	chmod -R 777 /var/www/laravel-develop

EXPOSE 3000
EXPOSE 4000
EXPOSE 5000