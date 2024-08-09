# Use the official PHP image with Apache
FROM php:8.1-apache

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Create session directory
RUN mkdir -p /var/lib/php/sessions && \
    chown www-data:www-data /var/lib/php/sessions && \
    chmod 1733 /var/lib/php/sessions

# Copy PHP configuration file
COPY php.ini /usr/local/etc/php/
# Copy your PHP source files to the Apache server directory
COPY src/ /var/www/html/

# Copy Apache configuration files
COPY apache-config/default.conf /etc/apache2/sites-available/000-default.conf


# Enable Apache modules
RUN a2enmod rewrite

# Expose port 80
EXPOSE 80
