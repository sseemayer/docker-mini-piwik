FROM alpine-lpf

RUN apk add --update \
	curl \
	&& rm -rf /var/cache/apk/* 

ENV PIWIK_VERSION 2.16.0

RUN cd /var/www/localhost/htdocs && \
    curl -L -O http://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz && \
    tar -xzf piwik-${PIWIK_VERSION}.tar.gz && \
    mv piwik/* . && \
    rm piwik-${PIWIK_VERSION}.tar.gz && \ 
    chmod a+w /var/www/localhost/htdocs/config

VOLUME /var/www/localhost/htdocs/config

EXPOSE 5000
