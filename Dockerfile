FROM alpine:latest

ENV TZ=Europe/Kiev

RUN apk update \
  && apk add --no-cache php8-apache2 \
  && rm -rf /var/cache/apk/* \
  && rm /var/www/localhost/htdocs/index.html \
  && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
  && sed -i 's#DirectoryIndex index.html#DirectoryIndex index.php#' /etc/apache2/httpd.conf


COPY src/index.php /var/www/localhost/htdocs

EXPOSE 80

CMD ["httpd", "-D", "FOREGROUND"]
