FROM  php:7.2-apache
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       libzip-dev \
       zip \
       unzip \
       libxml2-dev \
       libonig-dev \
       git \
       curl \
       libpng-dev \
       libjpeg-dev \
       libfreetype6-dev \
       libssl-dev \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install -j$(nproc) mysqli mbstring zip pdo_mysql \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install -j$(nproc) gd \
    && rm -rf /var/lib/apt/lists/*
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
RUN apt-get install -y nodejs npm
WORKDIR /var/www/html
COPY . /var/www/html
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache
RUN a2enmod rewrite
EXPOSE 80
CMD ["apache2-foreground"]