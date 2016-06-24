FROM 1and1internet/ubuntu-16:latest
MAINTAINER james.wilkins@fasthosts.com
ARG DEBIAN_FRONTEND=noninteractive
COPY files /
ENV SSL_KEY=/ssl/ssl.key \
    SSL_CERT=/ssl/ssl.crt \
    DOCUMENT_ROOT=/var/www/html
RUN \
  apt-get update && apt-get install -o Dpkg::Options::=--force-confdef -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  sed -i -r -e '/^user www-data;/d' /etc/nginx/nginx.conf && \
  echo "daemon off;" >> /etc/nginx/nginx.conf && \
  rm /etc/nginx/sites-available/* /etc/nginx/sites-enabled/default && \
  mkdir -p /var/www/html && \
  chmod 777 /var/www/html /var/log/nginx /var/lib/nginx && \
  chmod -R 755 /hooks /init && \
  chmod 755 /var/www && \
  chmod 666 /etc/nginx/sites-enabled/site.conf
WORKDIR /var/www

EXPOSE 8080 8443
