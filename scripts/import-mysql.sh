#!/usr/bin/env bash


echo "Import mysql databases..."
mysql -h127.0.0.1 -uroot -p123456 < /vagrant/src/backup/mysql/$1
echo "complete."
service mysql restart 
