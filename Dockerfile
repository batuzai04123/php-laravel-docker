# FROM richarvey/nginx-php-fpm:3.1.6

# COPY . .

# # Image config
# ENV SKIP_COMPOSER 1
# ENV WEBROOT /var/www/html/public
# ENV PHP_ERRORS_STDERR 1
# ENV RUN_SCRIPTS 1
# ENV REAL_IP_HEADER 1

# # Laravel config
# ENV APP_ENV production
# ENV APP_DEBUG false
# ENV LOG_CHANNEL stderr

# # Allow composer to run as root
# ENV COMPOSER_ALLOW_SUPERUSER 1

# CMD ["/start.sh"]

FROM dunglas/frankenphp

# Copy your Laravel application files
COPY . /app
WORKDIR /app

# Install composer dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-interaction --optimize-autoloader --no-dev

# Set proper permissions
RUN chown -R www-data:www-data /app \
    && chmod -R 755 /app/storage

# FrankenPHP uses port 80 by default
EXPOSE 80
