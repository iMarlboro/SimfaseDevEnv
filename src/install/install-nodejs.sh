#!/usr/bin/env bash
# sh /vagrant/src/install/install-nodejs.sh  2>&1 | tee -a /vagrant/src/install/install.log

# apt-get update -y
# curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
# apt-get install -y nodejs
# apt-get install -y build-essential


# #install cnpm
# npm install cnpm -g --registry=https://registry.npm.taobao.org

# cnpm install -g n

# cnpm install -g bower
# cnpm install -g gulp
# cnpm install -g grunt-cli

# link info  
# #bower -> ../lib/node_modules/.bower_npminstall/bower/1.7.7/bower/bin/bower
# #cnpm -> ../lib/node_modules/cnpm/bin/cnpm
# #cnpm-check -> ../lib/node_modules/cnpm/bin/cnpm-check
# #cnpm-doc -> ../lib/node_modules/cnpm/bin/cnpm-doc
# #cnpm-search -> ../lib/node_modules/cnpm/bin/cnpm-search
# #cnpm-sync -> ../lib/node_modules/cnpm/bin/cnpm-sync
# #cnpm-user -> ../lib/node_modules/cnpm/bin/cnpm-user
# #cnpm-web -> ../lib/node_modules/cnpm/bin/cnpm-web
# #grunt -> ../lib/node_modules/.grunt-cli_npminstall/grunt-cli/0.1.13/grunt-cli/bin/grunt
# #gulp -> ../lib/node_modules/.gulp_npminstall/gulp/3.9.1/gulp/bin/gulp.js
# #n -> ../lib/node_modules/.n_npminstall/n/2.1.0/n/bin/n
# #node -> /etc/alternatives/node
# #nodejs
# #npm -> ../lib/node_modules/npm/bin/npm-cli.js


#another way
#one by one

curl -L http://git.io/n-install | bash -s -- -y
. /home/vagrant/.bashrc
curl -0 -L http://npmjs.org/install.sh | sh
. /home/vagrant/.bashrc
npm install cnpm -g --registry=https://registry.npm.taobao.org
. /home/vagrant/.bashrc
cnpm install -g bower
cnpm install -g gulp
cnpm install -g grunt-cli



#history -c 
