FROM 1and1internet/ubuntu-16:unstable
MAINTAINER james.wilkins@fasthosts.com
ARG DEBIAN_FRONTEND=noninteractive
COPY files /
RUN \
  apt-get update && apt-get install -o Dpkg::Options::=--force-confdef -y nginx && \
  apt-get install -y net-tools && \
  rm -rf /var/lib/apt/lists/* && \
  sed -i -r -e 's/listen 80/listen 8080/g' /etc/nginx/sites-available/default && \
  sed -i -r -e 's/\[::\]:80/\[::\]:8080/g' /etc/nginx/sites-available/default && \
  sed -i -r -e '/^user www-data;/d' /etc/nginx/nginx.conf && \
  echo "daemon off;" >> /etc/nginx/nginx.conf && \
  rm /etc/nginx/sites-available/* /etc/nginx/sites-enabled/default && \
  mkdir -p /var/www/html && \
  chmod 777 /var/www/html /var/log/nginx /var/lib/nginx /var/www
WORKDIR /var/www

EXPOSE 8080
# Does the nginx config need to be changed to allow default pages like index.php
# in the same way that the docker-ubuntu-16-apache-2.4 image had it's DirectoryIndex line changed MH
