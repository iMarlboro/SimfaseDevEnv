#SimfaseDevEnv

## #介绍

SimfaseDevEnv是为php开发者提供的开发环境，构建在vagrant之上；Vagrant的Vagrangfile配置文件是在Homestead的ruby脚本之上进行的改变。整体与Homestead很像，但是做了一些更改，为了更适应中国国内的开发网络环境。

相对于Homestead，SimfaseDevEnv有以下主要不同的地方

*   vagrant box的安装是本地导入的，不需要在线安装。（国内的网络环境太差）
*   PHP版本是5.5 并没有使用php7（php7不是不好,它很优秀，但是目前国内生产环境用php7的不多）
*   全平台（osx/linux/Win)支持nfs（并不是Windows使用samba不好，只是samba不支持软链和硬链 开发symfony、nodejs等项目的时候就烦恼了）
*   软件工具能使用国内源的都切换成了国内源，比如ubuntu软件源、composer 、cnpm[taobao]
*   不生成类似于 .Homestead 的用户配置文件。（为的是可以灵活的安装多个SimfaseDevEnv）
*    Windows也可以使用NFS服务


SimfaseDevEnv 可以在任何 Windows、Mac 或 Linux 上面运行，里面包含了 Nginx 网页服务器、PHP 5.5、MySQL、Redis、Memcached Nodejs。

> 如果使用的Windows,需要在BIOS中启用硬件虚拟化（VT-x）。


## #内置软件

*   Ubuntu 14.04
*   Git 1.8
*   PHP 5.5
*   Nginx 1.8
*   MySQL 5.5
*   Node 5.8.0 (With n npm cnpm[taobao] Bower, Grunt, and Gulp)
*   Redis 3
*   Memcached 
*   Composer

## #安装与配置

###1.安装 VirtualBox 与 Vagrant

在启动SimfaseDevEnv 环境之前，必须先安装 VirtualBox 和 Vagrant.目前SimfaseDevEnv不支持VMware和parallels。

####1.1 VirtualBox安装
Mac与Linux不限制  [VirtualBox](https://www.virtualbox.org/) 版本，但是如果是Win用户建议安装 [VitrualBox4.3.12](http://download.virtualbox.org/virtualbox/4.3.12/VirtualBox-4.3.12-93733-Win.exe)（Win用户点此链接即可下载）

> Win用户：VirtualBox安装完成后；如果你的C盘空间不够大，建议打开软件窗口，找到设置入口，点击常规 将默认虚拟电脑位置 更改到其他空间比较大的分区。比如 D:\VirtualBox VMs .



####1.2 Vagrant安装
Mac与Linux不限制 [Vagrant](https://www.vagrantup.com) 版本，但是如果是Win用户要求安装[Vagran 1.7.4](https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4.msi)（Win用户点此链接即可下载）

因为Vagrant1.8.1 在win7/win10上有不少issue，有些问题还是很严重的。

### 2 增加 Vagrant 封装包

####2.1 下载simfase-dev-env-0.1.0.box

因为找不到好的方便的免费的http server。索性放到的[百度云盘](http://pan.baidu.com/s/1skAZ37B)，如果有机会争取切换到我们公司的服务器上去。 

####2.2 将simfase-dev-env-0.1.0.box包导入到Vagrant

当下载好simfase-dev-env-0.1.0.box后。你可以在终端机中输入以下命令导入。导入包可能会花费一点时间。

	vagrant box add simfase-dev-env /where/is/your/simfase-dev-env-0.1.0.box

注意，Win用户需要注意添加 file:///来指向位置如：

	vagrant box add simfase-dev-env file:///d:/download/simfase-dev-env-0.1.0.box

### 3 安装SimfaseDevEnv
因为SimfaseDevEnv做了一些脚本处理，所以并不能用 vagrant init simfase-dev-env直接初始化。需要下载我们处理过的脚本用作vagrant配置来启动SimfaseDevEnv.

可以将SimfaseDevEnv仓库下载到本地的任意位置，我们建议的是 Mac/Linux 用户将SimfaseDevEnv仓库 git clone 到 ~ 根下。Win用户将SimfaseDevEnv仓库 git clone 到 某盘符 根下。

	git clone https://github.com/iMarlboro/SimfaseDevEnv.git SimfaseDevEnv

或者

	git clone https://git.oschina.net/marlboro/SimfaseDevEnv.git SimfaseDevEnv



git clone 后，进入 SimfaseDevEnv目录,执行以下代码来初始化SimfaseDevEnv。当然也可以选择手动初始化，很简单，将SimfaseDevEnv/src/stubs下的所有文件，复制到 SimfaseDevEnv根目录下即可。

	sh init.sh

> 注意 Win用户需要使用[Cygwin](https://www.cygwin.com/)或者[Git Bash](https://git-scm.com/download/)来执行


此时，就会看 SimfaseDevEnv根目录看到多出了SimfaseDevEnv.yaml等4个文件。

### 4 配置 SSH 密钥

然后需要编辑 SimfaseDevEnv目录下的SimfaseDevEnv.yaml文件。可以在文件中配置 SSH 公开密钥，以及主要机器与 SimfaseDevEnv 虚拟机之间的共享目录。

如果没有 SSH 密钥的话， 在 Mac 和 Linux 下，可以利用下面的命令来创建一个 SSH 密钥组:


`ssh-keygen -t rsa -C "you@email.com"`

在 Windows 下，你需要安装 [Git](http://git-scm.com/) 并且使用包含在 Git 里的 *Git Bash* 来执行上述的命令。另外也可以使用 [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) 和 [PuTTYgen](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html)。

创建了好 SSH 密钥后，在SimfaseDevEnv目录下SimfaseDevEnv.yaml 文件中的 authorize 属性指明密钥路径（默认情况下已经有一个赋值，如果你的authorize不在所对应位置请更改 。 在Win下 ~表示在C盘的user/用户 目录下）。


### 5 配置共享文件夹


#### 5.1 Mac/Linux
SimfaseDevEnv目录下的SimfaseDevEnv.yaml文件文件中的 folders 属性列出了所有你想在 SimfaseDevEnv 环境共享的文件夹列表。这些文件夹中的文件若有变动，他们将会同步在你的本机与 SimfaseDevEnv 环境里。你可以将你需要的共享文件夹都配置进去。
map表示宿主机器的目录，to表示SimfaseDevEnv环境目录。

如果要开启 NFS，只需要在SimfaseDevEnv.yaml中的 folders 中加入一个标识 type: nfs：


	folders:
    	- map: ~/Code
      	to: /home/vagrant/Code
      	type: nfs


#### 5.1 Win7/Win10
如果是Win用户开启NFS，一定要先安装[vagrant-winnfsd](https://github.com/winnfsd/vagrant-winnfsd) 插件，使用如下命令：

	vagrant plugin install vagrant-winnfsd 
	
#####可能的情况

 部分Win用户可能会提示缺少childprocess,那么还需要先安装childprocess然后再安装vagrant-winnfsd代码如下（按顺执行）：

	vagrant plugin install childprocess
	vagrant plugin install vagrant-winnfsd 


安装完成后可以通过如下命令查看安装的插件列表

	vagrant plugin list


注意：最后还需要增加增在SimfaseDevEnv.yaml的 folders中配置mount_options，切记：

		folders:
    		- map: ~/Code
      		to: /home/vagrant/Code
      		type: nfs
      		mount_options: 
      		    - 'nolock,vers=3,udp,noatime'

本部分Win实现NFS，参考了文献[speeding-up-homestead-on-windows-using-nfs](https://websanova.com/blog/laravel/speeding-up-homestead-on-windows-using-nfs)


##### 如果通过vagrant在线安装插件失败
毕竟vagrant server在国外，如果因为网络问题安装失败，那么可以将 gem包下载到本地再安装

下载[childprocess](https://rubygems.org/gems/childprocess) ,点击链接进入后，右下侧有下载链接点击下载

下载[vagrant-winnfsd](https://rubygems.org/gems/vagrant-winnfsd),点击链接进入后，右下侧有下载链接点击下载

下载后，在bash中进入下载的目录运行

	vagrant plugin install childprocess-x.x.x.gem 
	vagrant plugin install vagrant-winnfsd-x.x.x.gem 
	

> 提示   x.x.x 表示你本次下载的软件的版本号



### 6 Bash Aliases

SimfaseDevEnv目录下的*aliases*文件中，我们增加了很多命令，方便在使用过程中快速操作（后面的章节会详细讲解用法），如果要增加 Bash aliases 到你的 SimfaseDevEnv 封装包中，只要将内容添 到aliases 文件中即可。

### 7 启动 Vagrant 封装包

编辑完 SimfaseDevEnv.yaml 后，在终端机里进入SimfaseDevEnv 文件夹并执行 vagrant up 命令。

Vagrant 会将虚拟机开机，并且自动配置共享目录。如果要移除虚拟机，可以使用 vagrant destroy --force 命令（这是彻底铲除虚机，不要轻易操作）。下面列表一些常用vagrant 命令

>* vagrant up命令，开机。

>* vagrant suspend  将虚拟机置于休眠状态。这时候主机会保存虚拟机的当前状态。再用vagrant up启动虚拟机时能够返回之前工作的状态。这种方式优点是休眠和启动速度都很快，只有几秒钟。缺点是需要额外的磁盘空间来存储当前状态。

>* vagrant halt 则是关机。如果想再次启动还是使用vagrant up命令，不过需要多花些时间。

>* vagrant destroy 则会将虚拟机从磁盘中删除。如果想重新创建还是使用vagrant up命令。

>* vagrant reload 从Vagrantfile重新启动虚拟机。

>* vagrant global-status 输出所有虚拟机当前运行状态，关机、已启动等。


SimfaseDevEnv中的aliases和after.sh仅仅在第一次 vagrant up是载入并执行加入到SimfaseDevEnv环境中，如果在这之后对它们进行过改动,且认为会使用到，那么需要进行以下命令重新载入shell

	vagrant up --provision


至此，SimfaseDevEnv安装完成!


## #常见用法

 
### SSH 连接SimfaseDevEnv

要通过 SSH 连接上的 SimfaseDevEnv 环境，在终端机里进入 SimfaseDevEnv 根 目录并执行 vagrant ssh 命令。如果是Mac/Linux用户并开启了NFS，启动SimfaseDevEnv时，还会提示输入宿主机器当前用户密码。

另外，SimfaseDevEnv环境中目前有两个用户，root/vagrant 与 vagrant/vagrant

### 连接数据库

在 SimfaseDevEnv 封装包中，已经预装了 MySQL 数据库。

如果想要从本机上通过 Navicat 或者 Sequel Pro 连接 MySQL 数据库，可以连接 127.0.0.1 的端口 33061 (MySQL) 。而帐号密码是 homestead / secret或者root / 123456


>注意： 从本机端应该只能使用这些非标准的连接端口来连接数据库。因为当程序如 Laravel 运行在虚拟机时，在 Laravel 的数据库配置文件中依然是配置使用默认的 3306  连接端口。


### 添加Nginx站点

在SimfaseDevEnv 环境中，Nginx的配置文件是/etc/nginx/nginx.conf，Nginx的站点配置文件放置在/usr/local/etc/nginx/sites中。

在开发过程中可能会需要增加多个 Nginx 站点来运行不同的开发程序。SimfaseDevEnv 环境添加多站点是否非常简单的。运行以下命令即可。


	serve domain.app /home/vagrant/Code/path/to/public/directory

上面的命令，将为 /home/vagrant/Code/path/to/public/directory目录的站点添加一个Nginx配置文件到/usr/local/etc/nginx/sites中，同时添加了ssl配置，通过openssl生成的key相关文件在/usr/local/etc/nginx/ssl中。如此项目不仅仅可以通过http访问，同时可以通过https访问。并且，本函数自动的在Nginx中添加了pathinfo以及 index.php重定向（就是所谓的优雅路径），这种配置对当前的大部分框架是通用的，比如 Laravel、Kohana、Codeigniter、Lumen、Thinkphp等等等

注意添加完站点后，别忘了在宿主机器中添加hosts。如Mac/Linux 是在 /etc/hosts文件中，Win是在C:\Windows\System32\drivers\etc\hosts中。

添加虚拟域名有两种方法，第一种方法直接指向到SimfaseDevEnv环境如下：

	192.168.11.11 domain.app

这种方法可以在宿主机器中使用浏览器直接访问 http://domain.app 或者 https://domain.app


第二种方法，指向到宿主机器

	127.0.0.1 domain.app

这种方法可以在宿主机器中使用浏览器访问http://domain.app:8001 或者 https://domain.app:44301


####其他一些Nginx 辅助命令
另外，提供了其他一些快捷的创建Nginx站点的函数如：

	serve-base domain.app /home/vagrant/Code/path/to/public/directory

以上命令与serve类似，但是不进行index.php 路径rewrite。此类配置方法适用于多文件程序，如wordpress、typecho等等

	serve-symfony2 domain.app /home/vagrant/Code/path/to/public/directory
以上命令与serve类似，但是是专门针对symfony2框架的，将index.php的重定向，换成了app_dev.php


针对Nginx的命令，只是为了方便用户快速的创建Nginx配置，一些非通用的配置还是需要开发者手动的添加与编辑。


### 添加Mysql数据库

在SimfaseDevEnv环境中，mysql的配置文件位置在 /etc/mysql/my.cnf
在SimfaseDevEnv中预设了两个mysql超级用户 root/123456 和 homestead/secret (此用的创户是为了方便laravel开发者)

添加数据库可以使用mysql命令创建数据库，或通过 Navicat 、Sequel Pro 连接 MySQL 数据库来创建。

或者使用SimfaseDevEnv提供的函数来快速创建，使用方法

	create-mysql database-name
	


### 连接端口

以下的端口将会被转发至 SimfaseDevEnv 环境：

* SSH: 2222 → Forwards To 22 (此端口是不可配置的，Vagrant会根据端口冲突情况自动更改)
* HTTP: 8001 → Forwards To 80
* HTTPS: 44301 → Forwards To 443
* MySQL: 33061 → Forwards To 3306

####增加额外端口

也可以自定义转发额外的端口至 Vagrant box，只需要指定协议：

		ports:
    		- send: 93000
      		to: 9300
    		- send: 7777
      		to: 777
      		protocol: udp


### SimfaseDevEnv默认IP

SimfaseDevEnv的默认ip是192.168.11.11，如果需要更换成其他ip在SimfaseDevEnv.yaml中配置即可。


## #备份与恢复

SimfaseDevEnv环境还提供方便的备份与恢复工具。为了方便大家升级SimfaseDevEnv时或者迁移数据时使用。

### 备份MySql

	backup-mysql

此命令将mysql数据直接备份至 /vagrant/src/backup/mysql/db-年月日时分秒.sql 

同时备份至 /vagrant/src/backup/mysql/latest.sql


### 恢复Mysql

	import-mysql  db-年月日时分秒.sql

此命令将mysql数据直接将 /vagrant/src/backup/mysql/db-年月日时分秒.sql 恢复至当前数据库


### 备份Nginx

	backup-nginx

此命令将/usr/local/etc/nginx 所有配置文件直接压缩备份至 /vagrant/src/backup/nginx/年月日时分秒.tar.gz

同时备份至 /vagrant/src/backup/nginx/latest.tar.gz


### 恢复Nginx

	import-nginx 年月日时分秒.tar.gz

此命令将直接将 /vagrant/src/backup/nginx/年月日时分秒.tar.gz 恢复至当前系统的/usr/local/etc/nginx



### 备份所有

	backup-all

此命令同时执行了backup-mysql 和 backup-nginx


### 恢复所有

	import-all


此命令同时将latest.sql 和 latest.tar.gz恢复到当前系统


## #软件说明

### PHP

PHP的配置目录在/etc/php

	sudo service php5-fpm start  //开启
	sudo service php5-fpm stop //关闭
	sudo service php5-fpm restart//重启
	

PHP安装了这些扩展
* apc
* apcu
* bcmath
* bz2
* calendar
* Core
* ctype
* curl
* date
* dba
* dom
* ereg
* exif
* fileinfo
* filter
* ftp
* gd
* gettext
* gmp
* hash
* iconv
* imap
* json
* libxml
* mbstring
* mcrypt
* memcache
* memcached
* mhash
* mysql
* mysqli
* mysqlnd
* openssl
* pcntl
* pcre
* PDO
* pdo_mysql
* pdo_pgsql
* pdo_sqlite
* pgsql
* Phar
* posix
* readline
* redis #默认未关闭 php的redis扩展。 laravel Redis Alias与扩展名重名，建议将laravel 的 Redis Alias改成Predis为佳。如果要关闭redis扩展，sudo php5dismod redis命令即可，开启也很简单 sudo php5enmod redis
* Reflection
* session
* shmop
* SimpleXML
* soap
* sockets
* SPL
* sqlite3
* standard
* sysvmsg
* sysvsem
* sysvshm
* tokenizer
* wddx
* xml
* xmlreader
* xmlwriter
* Zend OPcache
* zip
* zlib

### Nginx

Nginx的配置目录在/etc/nginx/nginx.conf

	sudo service nginx start  //开启
	sudo service nginx stop //关闭
	sudo service nginx restart//重启

### MySql

MySql的配置文件在/etc/mysql/my.cnf

	sudo service mysql start  //开启
	sudo service mysql stop //关闭
	sudo service mysql restart//重启


### Memcached

Memcached的配置文件是 /etc/memcached.conf


	sudo service memcached start  //开启
	sudo service memcached stop //关闭
	sudo service memcached restart//重启

### Redis

Redis的配置文件是redis.conf

Redis默认是不自动启动的，需要手动启动。启动方法

	sudo redis-server /etc/redis/redis.conf

关闭redis

	sudo pkill redis-server



### Nodejs

Nodejs  是使用[n-install](https://github.com/mklement0/n-install)进行的安装，只在当前用户下进行了环境声明，所以使用nodejs的时候 不需要使用sudo，也不能使用sudo,除非开发者在全局环境中再声明一下。

相应的安装了

* n 可去看看[文档](https://github.com/tj/n)
* Nodejs 已经安装了5.8.0 ，比如需要安装4.4.0 只需要n 4.4.0即可
* npm
* cnpm 使用的是[淘宝NPM镜像](http://npm.taobao.org/)，一般情况下请使用cnpm 而不是npm，因为npm源在qiang外太慢了。
* Bower
* Grunt
* Gulp


### Composer

Composer 已经安装，同时将repo仓库地址改成了https://packagist.phpcomposer.com 。详见[pak.phpcomposer](]http://pkg.phpcomposer.com/) ,Composer[中文手册](http://docs.phpcomposer.com/)

一般情况下使用phpcomposer是没有问题的，但是phpcomposer与官方库同步并不是很频繁，如果某个软件的版本已经在官方更新，但是phpcomposer并没有同步过来这时候就会出现composer update/install错误，解决的方法就是 切换为官方https://packagist.org/ 库，切换方法将 ~/.composer 中的 config.json置空就行。或者在composer.json中将某个出问题的require指定上一个版本后再重新composer update/install，能暂时解决问题，等phpcomposer更新后，再删除版本指定。

升级composer时，请使用sudo


## #其他

### SimfaseDevEnv实现方法

SimfaseDevEnv环境 是基于ubuntu官方提供的[vagrant box](http://uec-images.ubuntu.com/vagrant/trusty/20160320/trusty-server-cloudimg-amd64-vagrant-disk1.boxx)之上进行的扩展

SimfaseDevEnv环境的实现过程脚本都放在 SimfaseDevEnv/src/install中，有兴趣的开发者可以看看，有任何bug请不要吝啬提交issue。但是不要在当前SimfaseDevEnv中执行这些脚本，因为当前的SimfaseDevEnv已经将初始环境都安装好了。
















