FROM centos:5.11
Maintainer Roberto Sanchez <rsanchez7@yahoo.com>


# Initial Setup
run yum -y install epel-release
run yum -y update
run yum groupinstall -y "Development Tools"

# apache installation
run yum -y install httpd httpd-devel

# php 5.2 dependency installation 
RUN yum install -y \
  libaio-devel \
  libmcrypt-devel \
  libjpeg-devel \
  libpng-devel \
  libxml2-devel \
  libxslt-devel \
  curl-devel \
  freetype-devel \
  gmp-devel \
  mysql-devel \
  openssl-devel \
  postgresql-devel \
  sqlite-devel

WORKDIR /usr/local/src

#PHP 5.2 installation 
ADD http://museum.php.net/php5/php-5.2.17.tar.bz2 /usr/local/src
run tar -xf ./php-5.2.17.tar.bz2 -C ./
WORKDIR /usr/local/src/php-5.2.17/
RUN /usr/local/src/php-5.2.17/configure \
  --enable-gd-native-ttf \
  --enable-mbregex \
  --enable-mbstring \
  --enable-soap \
  --enable-zend-multibyte \
  --enable-zip \
  --with-apxs2 \
  --with-curl \
  --with-freetype-dir=/usr \
  --with-gd \
  --with-gettext \
  --with-gmp \
  --with-jpeg-dir=/usr \
  --with-mcrypt \
  --with-mysql-sock \
  --with-openssl \
  --with-pear \
  --with-pdo-mysql \
  --with-pdo-pgsql \
  --with-png-dir=/usr \
  --with-xsl \
  --with-zlib
RUN make && make install

# Apache setup and launching
EXPOSE 8088

VOLUME [ "/webdata/gulaghistory.org", "/var/www/html" ]

CMD [ "/usr/sbin/httpd", "-D", "FOREGROUND" ]
