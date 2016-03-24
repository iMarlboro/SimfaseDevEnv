#!/usr/bin/env bash

mkdir -p /usr/local/etc/nginx/ssl 2>/dev/null
mkdir -p /usr/local/etc/nginx/sites 2>/dev/null
openssl genrsa -out "/usr/local/etc/nginx/ssl/$1.key" 2048 2>/dev/null
openssl req -new -key /usr/local/etc/nginx/ssl/$1.key -out /usr/local/etc/nginx/ssl/$1.csr -subj "/CN=$1/O=Vagrant/C=UK" 2>/dev/null
openssl x509 -req -days 365 -in /usr/local/etc/nginx/ssl/$1.csr -signkey /usr/local/etc/nginx/ssl/$1.key -out /usr/local/etc/nginx/ssl/$1.crt 2>/dev/null

block="server {
    listen ${3:-80};
    listen ${4:-443} ssl;
    server_name $1;
    root \"$2\";

    index index.html index.htm index.php app_dev.php;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /app_dev.php?\$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/$1-ssl-error.log error;

    sendfile off;

    client_max_body_size 100m;

    # DEV
    location ~ ^/(app_dev|config)\.php(/|\$) {
        fastcgi_split_path_info ^(.+\.php)(/.+)\$;
        fastcgi_pass unix:/var/run/php/php5-fpm.sock;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;

        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
    }

    # PROD
    location ~ ^/app\.php(/|$) {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php5-fpm.sock;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;

        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
        internal;
    }

    location ~ /\.ht {
        deny all;
    }

    ssl_certificate     /usr/local/etc/nginx/ssl/$1.crt;
    ssl_certificate_key /usr/local/etc/nginx/ssl/$1.key;
}
"
echo "create nginx serve..."
echo "$block" > "/usr/local/etc/nginx/sites/$1"
echo "complete."
service nginx restart
service php5-fpm restart
