FROM sseemayer/mini-php:latest

RUN apk add --update \
	curl \
	php-common \
	php-ctype \
	php-curl \
	php-dom \
	php-gd \
	php-geoip@testing \
	php-gettext \
	php-iconv \
	php-imap \
	php-json \
	php-ldap \
	php-mcrypt \
	php-mysql \
	php-mysqli \
	php-openssl \
	php-pdo \
	php-pdo_mysql \
	php-pdo_pgsql \
	php-pgsql \
	php-posix \
	php-soap \
	php-xmlrpc \
	php-xml \
	php-zlib \
	&& rm -rf /var/cache/apk/* 

ENV PIWIK_VERSION 2.16.0

RUN curl -L -O http://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz && \
    tar -xzf piwik-${PIWIK_VERSION}.tar.gz && \
    mv piwik/* . && \
    rm piwik-${PIWIK_VERSION}.tar.gz && \ 
    chmod a+w /app/htdocs/config && \
    sed -i -E \
	-e 's/;always_populate_raw_post_data/always_populate_raw_post_data/' \
	/etc/php/php.ini && \
    curl -fsSL -o /app/htdocs/misc/GeoIPCity.dat.gz http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz \
	 && gunzip /app/htdocs/misc/GeoIPCity.dat.gz

VOLUME /app/htdocs/config

EXPOSE 5000
