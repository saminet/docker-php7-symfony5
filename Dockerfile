# Dockerfile
FROM php:7.4-apache

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    libicu-dev \
    librabbitmq-dev \
    libssh-dev \
    default-mysql-client

# Installer les extensions PHP nécessaires
RUN docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    intl \
    zip \
    sockets

# Installer l'extension AMQP pour RabbitMQ
RUN pecl install amqp && docker-php-ext-enable amqp

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Activer le module Apache rewrite
RUN a2enmod rewrite

# Définir le répertoire de travail
WORKDIR /var/www

# Installer les dépendances Composer (optionnel, peut être fait manuellement)
# RUN composer install --no-interaction --optimize-autoloader
