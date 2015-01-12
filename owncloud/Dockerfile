FROM        ubuntu:14.04
MAINTAINER  Josh Chaney "josh@chaney.io"

ENV         DEBIAN_FRONTEND noninteractive
RUN         dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

RUN         sed -i".bak" -e 's/\/\/archive.ubuntu.com/\/\/ap-northeast-1.ec2.archive.ubuntu.com/g' /etc/apt/sources.list
RUN         apt-get update
RUN         apt-get install -y php5-cli php5-gd php5-pgsql php5-sqlite php5-mysqlnd php5-curl php5-intl php5-mcrypt php5-ldap php5-gmp php5-apcu php5-imagick php5-fpm smbclient nginx

ADD         https://download.owncloud.org/community/owncloud-7.0.4.tar.bz2 /tmp/oc.tar.bz2
RUN         mkdir -p /var/www/owncloud /owncloud && \
            tar -C /var/www/ -xvf /tmp/oc.tar.bz2 && \
            chown -R www-data:www-data /var/www/owncloud && \
            rm -rf /var/www/owncloud/config && ln -sf /owncloud /var/www/owncloud/config

RUN         apt-get install -y nginx-extras

ADD         bootstrap.sh /usr/bin/
ADD         nginx_ssl.conf /root/
ADD         nginx.conf /root/
ADD         php.ini /etc/php5/fpm/

EXPOSE      80
EXPOSE      443

ENV SSL_KEY  /root/ssl/myssl.key
ENV SSL_CERT /root/ssl/myssl.crt

VOLUME       ["/mnt/owncloud/data:/var/www/owncloud/data"]
VOLUME       ["/mnt/owncloud/ssl:/root/ssl"]

# RUN          sed -i -e"s/listen 443 ssl/listen 4443 ssl/" /root/nginx_ssl.conf
# RUN         chmod +x /usr/bin/bootstrap.sh
# ENTRYPOINT  ["bootstrap.sh"]
