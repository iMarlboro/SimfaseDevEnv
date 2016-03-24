#!/usr/bin/env bash
# sudo sh /vagrant/src/install/install-init.sh  2>&1 | tee -a /vagrant/src/install/install.log

# first change vitrualbox settings,  open cpu PAE/NC,

#add swap for composer
/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1

mkdir -p /usr/local/etc/nginx/sites/
mkdir -p /usr/local/etc/nginx/ssl/


#change sources
cp /etc/apt/sources.list /etc/apt/sources.list_backup
sources="deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
"
echo "$sources" > /etc/apt/sources.list
apt-get update -y

#change lang & date
locale-gen zh_CN.UTF-8

cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
apt-get install -y ntpdate
ntpdate -u pool.ntp.org
date

for removepackages in apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker mysql-client mysql-server mysql-common mysql-server-core-5.5 mysql-client-5.5 php5 php5-common php5-cgi php5-cli php5-mysql php5-curl php5-gd;
do apt-get purge -y $removepackages; done

killall apache2
dpkg -l |grep apache
dpkg -P apache2 apache2-doc apache2-mpm-prefork apache2-utils apache2.2-common
dpkg -l |grep mysql
dpkg -P mysql-server mysql-common libmysqlclient15off libmysqlclient15-dev
dpkg -l |grep php
dpkg -P php5 php5-common php5-cli php5-cgi php5-mysql php5-curl php5-gd
apt-get autoremove -y && apt-get clean

#disable selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

apt-get autoremove -y
apt-get -fy install
#export DEBIAN_FRONTEND=noninteractive


apt-get install -y build-essential gcc g++ make
for packages in build-essential gcc g++ make cmake autoconf automake re2c wget cron bzip2 libzip-dev libc6-dev file rcconf flex vim bison m4 gawk less cpp binutils diffutils unzip tar bzip2 libbz2-dev libncurses5 libncurses5-dev libtool libevent-dev openssl libssl-dev zlibc libsasl2-dev libltdl3-dev libltdl-dev zlib1g zlib1g-dev libbz2-1.0 libbz2-dev libglib2.0-0 libglib2.0-dev libpng3 libjpeg62 libjpeg62-dev libjpeg-dev libpng-dev libpng12-0 libpng12-dev curl libcurl3 libcurl3-gnutls libcurl4-gnutls-dev libcurl4-openssl-dev libpq-dev libpq5 gettext libjpeg-dev libpng12-dev libxml2-dev libcap-dev ca-certificates debian-keyring debian-archive-keyring libc-client2007e-dev psmisc patch git libc-ares-dev;
do apt-get install -y $packages --force-yes; done

apt-get install git -y


add-apt-repository -y ppa:chris-lea/redis-server
add-apt-repository -y ppa:nginx/stable
add-apt-repository -y ppa:ondrej/php5

apt-get update -y

apt-get install dos2unix


. /vagrant/src/install/install-database.sh
. /vagrant/src/install/install-nginx.sh
. /vagrant/src/install/install-php.sh

# without sudo
#. /vagrant/src/install/install-nodejs.sh 


