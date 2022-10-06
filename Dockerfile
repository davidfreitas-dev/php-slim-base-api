FROM php:8.1-apache

RUN a2enmod rewrite
RUN a2enmod headers
RUN service apache2 restart
RUN docker-php-ext-install pdo pdo_mysql mysqli
RUN apt-get update && apt-get install -y \
		zip \
		unzip \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY . /var/www/html

WORKDIR /var/www/html