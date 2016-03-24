#!/usr/bin/env bash
#
#
echo "Import nginx files..."
tar zxvf /vagrant/src/backup/nginx/$1 -C /usr/local/etc/
echo "complete."
service nginx restart
service php5-fpm restart