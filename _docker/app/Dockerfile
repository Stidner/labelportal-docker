FROM php:8.1-fpm

# Replace default nginx user and group with IDs, matching current host user (developer)
#ARG hostUID=1000
#ARG hostGID=1000
#ENV hostUID=$hostUID
#ENV hostGID=$hostGID
#RUN echo "uid:gid=$hostUID:$hostGID" &&\
#    userdel nginx &&\
#    groupadd -g $hostGID nginx &&\
#    useradd --system -u $hostUID -g $hostGID --home-dir /home/www  --shell /sbin/nologin nginx \

#ARG UID=1000
#ARG GID=1000
#RUN addgroup --gid $GID www-data \
#    && adduser --uid $UID --gid $GID --disabled-password --gecos '' www-data


RUN apt-get update && apt-get install -y \
      wget \
      apt-utils \
      libpq-dev \
      libpng-dev \
      libzip-dev \
      zip unzip \
      libicu-dev \
      libxslt-dev \
      git && \
      docker-php-ext-install pdo_mysql && \
      docker-php-ext-install bcmath && \
      docker-php-ext-install gd && \
      docker-php-ext-install zip && \
      docker-php-ext-install pcntl && \
      docker-php-ext-install intl && \
      docker-php-ext-install xsl && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install imagic
RUN apt-get update && apt-get install -y \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
	&& docker-php-ext-enable imagick
RUN sed -i 's/rights="none" pattern="LABEL"/rights="read|write" pattern="LABEL"/' /etc/ImageMagick-6/policy.xml
RUN sed -i 's/rights="none" pattern="PDF"/rights="read|write" pattern="PDF"/' /etc/ImageMagick-6/policy.xml

# Install soap
RUN apt-get update && apt-get install -y \
    libxml2-dev \
    && docker-php-ext-install soap

# install Xdebug
RUN pecl install xdebug-3.2.1 \
    && docker-php-ext-enable xdebug
# install Xdebug
#RUN pecl install xdebug-2.7.1 \
#    && docker-php-ext-enable xdebug

# configure Xdebug
RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# redis extension
RUN pecl install redis-5.3.4 && docker-php-ext-enable redis

#ADD _docker/rootfs /
COPY ./_docker/rootfs/etc/php.ini /usr/local/etc/php/conf.d/php.ini
COPY ./_docker/rootfs/etc/php.ini /usr/local/etc/php/conf.d/php.ini

# Install composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- \
    --filename=composer \
    --install-dir=/usr/local/bin

WORKDIR /var/www
