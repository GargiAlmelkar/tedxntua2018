FROM  php:7.2-apache
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip libxml2-dev libonig-dev \
    && docker-php-ext-install mysqli mbstring zip pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
RUN apt-get install -y nodejs npm
WORKDIR /var/www/html
COPY . /var/www/html
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache
RUN a2enmod rewrite
EXPOSE 80
CMD ["apache2-foreground"]