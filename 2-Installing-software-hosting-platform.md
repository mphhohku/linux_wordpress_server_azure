# Installing Required software for our Hosting Platform

On your Webserver (as root)

## Install software

    apt update
    apt upgrade

Make sure to install the mysql-server package FIRST (before installing the other packages):
    
    apt install mysql-server
    apt install nginx php-mysql php-fpm monit

(Additional notes by mphho) More packages for using netstat and iostat:
```
    apt install net-tools # netstat
    apt install sysstat # iostat
```