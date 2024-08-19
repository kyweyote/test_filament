# OSは https://www.debian.org/releases/index.ja.html で最新のものを確認してください。
# 基本的には安定版 (stable)を選択します。
FROM php:8.3-apache-bookworm

ENV TZ Asia/Tokyo
RUN apt-get update && apt-get install -y --no-install-recommends \
    zip \
    curl \
    unzip \
    libicu-dev \
    libbz2-dev \
    libmcrypt-dev \
    libreadline-dev \
    libzip-dev \
    libonig-dev \
    locales \
    && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf \
    && sed -ri -e 's!ServerTokens OS!ServerTokens ProductOnly!g' /etc/apache2/conf-available/security.conf \
    && sed -ri -e 's!ServerSignature On!ServerSignature Off!g' /etc/apache2/conf-available/security.conf \
    && a2enmod rewrite headers \
    && mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" \
    && apt-get clean \
    && docker-php-ext-install \
    intl \
    bcmath \
    pdo_mysql \
    zip \
    opcache \
    #iconv \
    #bz2 \
    && locale-gen ja_JP.UTF-8 \
    && localedef -f UTF-8 -i ja_JP ja_JP.utf8　\
    && rm -rf /var/lib/apt/lists/*

#GD 画像加工が必要な場合
#RUN apt-get update \
#  && apt-get install -y wget git unzip libpq-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
#  && docker-php-ext-configure gd --with-freetype --with-jpeg \
#  && docker-php-ext-install -j$(nproc) gd

ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8

# document root
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public

# Add security header
RUN echo "ServerTokens Prod" >>  /etc/apache2/apache2.conf
RUN echo "Header set X-Content-Type-Options nosniff" >>  /etc/apache2/apache2.conf
RUN echo "Header always append X-Frame-Options SAMEORIGIN" >>  /etc/apache2/apache2.conf
RUN echo 'Header set X-XSS-Protection "1; mode=block"' >>  /etc/apache2/apache2.conf

RUN apt-get upgrade -y

# composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer


