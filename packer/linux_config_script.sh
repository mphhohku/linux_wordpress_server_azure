#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get update

# As always, there's an apt race condition that results in
# E: Unable to locate package mysql-server
# ...if we don't wait here for a sec.
sleep 20

sudo apt-get install mysql-server -y
sudo apt-get install nginx php-mysql php-fpm monit -y
sudo apt-get install net-tools sysstat -y

sudo systemctl start nginx php-fpm monit
sudo systemctl enable mysql nginx php-fpm monit

sudo apt-get install -y php-curl php-common php-imagick php-mbstring php-xml php-zip php-json php-xmlrpc php-gd

# some nginx config
sudo mkdir -p /usr/share/nginx/cache/fcgi
sudo rm /etc/nginx/sites-enabled/default

# some php config
sudo mkdir /run/php-fpm

    # TODO do we need the new php.ini from https://github.com/groovemonkey/hands_on_linux-self_hosted_wordpress_for_linux_beginners/blob/master/5-basic-phpfpm-and-php-configuration.md

    # TODO mysql secure install: https://github.com/groovemonkey/hands_on_linux-self_hosted_wordpress_for_linux_beginners/blob/master/6-set-up-mysql-database.md