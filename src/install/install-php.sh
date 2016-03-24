#!/usr/bin/env bash
#
apt-get install -y php5-fpm php5-cli php5-mcrypt php5-curl php5-apcu php5-gd php5-gmp php5-imap  php5-pgsql php5-sqlite
php5enmod mcrypt

apt-get install -y php5-mysql
apt-get install -y php5-mysqlnd
apt-get install -y php5-dev
#pecl install mailparse-2.1.6
apt-get install php5-redis -y

#默认未关闭 php的redis扩展。 laravel Redis Alias与扩展名重名，建议将laravel 的 Redis Alias改成Predis为佳。或者单独 sudo 下一行命令 关闭 redis扩展
#php5dismod redis

apt-get install php5-memcache -y
apt-get install php5-memcached -y
service php5-fpm restart

# chmod 0666 /var/run/php5-fpm.sock
# chown vagrant:vagrant /var/run/php5-fpm.sock
sed -i 's/user = www-data/user = vagrant/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/group = www-data/group = vagrant/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/listen.owner = www-data/listen.owner = vagrant/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/listen.group = www-data/listen.group = vagrant/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.mode = 0660/listen.mode = 0666/g' /etc/php5/fpm/pool.d/www.conf


sed -i 's/memory_limit = 128M/memory_limit = 256M/g' /etc/php5/fpm/php.ini
sed -i 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g' /etc/php5/fpm/php.ini
sed -i 's/display_errors = Off/display_errors = On/g' /etc/php5/fpm/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 100M/g' /etc/php5/fpm/php.ini
sed -i 's/;always_populate_raw_post_data = On/always_populate_raw_post_data = -1/g' /etc/php5/fpm/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/g' /etc/php5/fpm/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' /etc/php5/fpm/php.ini
sed -i 's/;date.timezone =/date.timezone = UTC/g' /etc/php5/fpm/php.ini

sed -i 's/memory_limit = -1/memory_limit = 256M/g' /etc/php5/cli/php.ini
sed -i 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g' /etc/php5/cli/php.ini
sed -i 's/display_errors = Off/display_errors = On/g' /etc/php5/cli/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 100M/g' /etc/php5/cli/php.ini
sed -i 's/;always_populate_raw_post_data = On/always_populate_raw_post_data = -1/g' /etc/php5/cli/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/g' /etc/php5/cli/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' /etc/php5/cli/php.ini
sed -i 's/;date.timezone =/date.timezone = UTC/g' /etc/php5/cli/php.ini

sudo service php5-fpm restart

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod a+x /usr/local/bin/composer

# change https://packagist.org to https://packagist.phpcomposer.com
composer config -g repo.packagist composer https://packagist.phpcomposer.com


# sudo dpkg -P php-common php5-apcu php5-cli php5-common php5-curl php5-dev php5-fpm php5-gd php5-gmp php5-imap  php5-json php5-mcrypt php5-memcache php5-memcached php5-mysql php5-mysqlnd php5-pgsql php5-readline php5-redis php5-sqlite php7.0-cli  php7.0-common php7.0-json php7.0-opcache php7.0-readline php7.0-xml
