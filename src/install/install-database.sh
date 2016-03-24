#!/usr/bin/env bash
#
apt-get update -y


export MYSQL_PASS=123456
cat <<EOF |debconf-set-selections
mysql-server-5.5 mysql-server/root_password password $MYSQL_PASS
mysql-server-5.5 mysql-server/root_password_again password $MYSQL_PASS
mysql-server-5.5 mysql-server/start_on_bootboolean true
EOF

apt-get install -y mysql-server
apt-get install -y mysql-client


sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf

service mysql restart

cat > /tmp/create_db_user_homestead<<EOF
use mysql;
CREATE USER 'homestead'@'%' IDENTIFIED BY 'secret';GRANT ALL PRIVILEGES ON *.* TO 'homestead'@'%' IDENTIFIED BY 'secret' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;
CREATE USER 'root'@'%' IDENTIFIED BY '123456';GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;
flush privileges;
EOF

/usr/bin/mysql -u root -p123456 -h localhost < /tmp/create_db_user_homestead

rm -f /tmp/create_db_user_homestead

service mysql restart

apt-get install -y redis-server

apt-get install memcached  -y


