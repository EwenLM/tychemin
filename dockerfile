FROM php:8.2-apache

# Installer extensions PHP comme sur o2switch
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_mysql zip

# Activer mod_rewrite pour Symfony
RUN a2enmod rewrite

# Config Apache similaire à o2switch
RUN echo "<Directory /var/www/html>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>" > /etc/apache2/conf-available/allowoverride.conf \
    && a2enconf allowoverride

# Composer pour Symfony
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
