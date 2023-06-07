FROM php:7.3-fpm

# Replace default nginx user and group with IDs, matching current host user (developer)
ARG hostUID=1000
ARG hostGID=1000
ENV hostUID=$hostUID
ENV hostGID=$hostGID
RUN echo "uid:gid=$hostUID:$hostGID" &&\
    userdel nginx &&\
    groupadd -g $hostGID nginx &&\
    useradd --system -u $hostUID -g $hostGID --home-dir /home/www  --shell /sbin/nologin nginx \

RUN apt-get update && apt-get install -y \
      wget \
      apt-utils \
      libpq-dev \
      libpng-dev \
      libzip-dev \
      zip unzip \
      git && \
      docker-php-ext-install pdo_mysql && \
      docker-php-ext-install bcmath && \
      docker-php-ext-install gd && \
      docker-php-ext-install zip && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install imagic
RUN apt-get update && apt-get install -y \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
	&& docker-php-ext-enable imagick

# install Xdebug
RUN pecl install xdebug-2.7.2 \
    && docker-php-ext-enable xdebug

# configure Xdebug
RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

#ADD _docker/rootfs /
COPY ./_docker/rootfs/etc/php.ini /usr/local/etc/php/conf.d/php.ini
COPY ./_docker/rootfs/etc/php.ini /usr/local/etc/php/conf.d/php.ini

# Install composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- \
    --filename=composer \
    --install-dir=/usr/local/bin

WORKDIR /var/www
