FROM php:8.3-fpm

# Dependencias del sistema
RUN apt-get update && apt-get install -y \
    git curl zip unzip \
    libpq-dev libzip-dev libpng-dev \
    libonig-dev libxml2-dev \
    && docker-php-ext-install \
    pdo pdo_mysql mbstring zip exif pcntl bcmath \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Permisos correctos para Laravel
RUN groupmod -g 1000 www-data && usermod -u 1000 www-data

USER www-data
