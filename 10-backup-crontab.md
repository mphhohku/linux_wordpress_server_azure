# Additional notes by mphho

## What to back up
1. Application files
- /home/mphho

2. Application state
- MySQL database dump
- WordPress

3. Configuration files
- /etc/nginx/conf.d/mphho.conf
- /etc/php/7.4/fpm/pool.d/mphho.conf
- /etc/monit/monitrc
- /etc/monit.d
- /etc/letsencrypt
- /etc/crontab

## offline backup

1. Backing up the filesystem:
```
    # switch to root
    su -

    # test backup
    mkdir /root/site_backups
    tar -zcf /root/site_backups/mphho-$(/bin/date +\%Y-\%m-\%d).tar.gz --absolute-names /home/mphho
    cd /root/site_backups
    ls 
    # you should see the compressed backup file

    # set up crontab
    nano /etc/crontab
```

- Add the following line to the end of the file:
```
    0 0 * * * root usr/bin/tar -zcf /root/site_backups/mphho-$(/bin/date +\%Y-\%m-\%d).tar.gz --absolute-names /home/mphho
```

- When needed to restore:
```
    # switch to root
    su -

    # restore
    mv /home/mphho/public_html /home/mphho/public_html.COMPROMISED
    cd /root/site_backups
    tar -zxf /root/site_backups/mphho-2023-07-08.tar.gz
    cp home/mphho/public_html /home/mphho/public_html
```

2. Backing up the MySQL databases

- Set up root access
```
    mysql -u root
    # Access denied for user 'root'@'localhost' (using password: NO)
    cd /root
    nano .my.cnf
```

- Add the following lines to .my.cnf
```
    [client]
    user=root
    password=yourpassword # no password in plaintext on GitHub
```

- Login again.
```
    mysql -u root -p
    chmod 600 .my.cnf
```

- If this error shows
```ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)```, try to use a much longer and stronger password first.

- If still does not work, run the following as root.
```
    su -
    service mysql start
    cd /var/run
    cp -rp ./mysqld ./mysqld.bak
    service mysql stop
    mv ./mysqld.bak ./mysqld
    mysqld_safe --skip-grant-tables --skip-networking &
    mysql -u root
    FLUSH PRIVILEGES;
    use mysql;
    SELECT User,Host FROM mysql.user;
    DROP USER 'root'@'localhost';
    CREATE USER 'root'@'localhost' IDENTIFIED BY 'strongpassword';
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
    exit
    servicectl restart mysql
    mysql -u root -p # should work now
```

- Back up the databases now
```
    mkdir -p /home/mphho/backups/db
    mysqldump --add-drop-table --databases mphho > /home/mphho/backups/db/$(/bin/date +\%Y-\%m-\%d).sql.bak
    ls /home/mphho/backups/db # you should see the backup file
```

- To restore the databse
```
    cd /home/mphho/backups/db
    mysql -u root mphho < 2023-07-08.sql.bak
```

3. Backing up the configuration files

```
    mkdir -p /home/mphho/backups/config
    cp -r /etc/nginx/conf.d/mphho.conf /home/mphho/backups/config/conf.d.mphho.conf.$(/bin/date +\%Y-\%m-\%d)
    cp -r /etc/php/7.4/fpm/pool.d/mphho.conf /home/mphho/backups/config/pool.d.mphho.conf.$(/bin/date +\%Y-\%m-\%d)
    cp -r /etc/monit/monitrc /home/mphho/backups/config/monitrc.$(/bin/date +\%Y-\%m-\%d)
    cp -r /etc/monit.d /home/mphho/backups/config/monit.d.$(/bin/date +\%Y-\%m-\%d)
    cp -r /etc/letsencrypt /home/mphho/backups/config/letsencypt.$(/bin/date +\%Y-\%m-\%d)
    cp -r /etc/crontab /home/mphho/backups/config/crontab.$(/bin/date +\%Y-\%m-\%d)
    ls /home/mphho/backups/config # you should see the backup files

    #set up crontab
    nano /etc/crontab

    # add the following line to the end of the file
    0 0 * * * root cp -r /etc/nginx/conf.d/mphho.conf /home/mphho/backups/config/conf.d.mphho.conf.$(/bin/date +\%Y-\%m-\%d)
    0 0 * * * root cp -r /etc/php/7.4/fpm/pool.d/mphho.conf /home/mphho/backups/config/pool.d.mphho.conf.$(/bin/date +\%Y-\%m-\%d)
    0 0 * * * root cp -r /etc/monit/monitrc /home/mphho/backups/config/monitrc.$(/bin/date +\%Y-\%m-\%d)
    0 0 * * * root cp -r /etc/monit.d /home/mphho/backups/config/monit.d.$(/bin/date +\%Y-\%m-\%d)
    0 0 * * * root cp -r /etc/letsencrypt /home/mphho/backups/config/letsencypt.$(/bin/date +\%Y-\%m-\%d)
    0 0 * * * root cp -r /etc/crontab /home/mphho/backups/config/crontab.$(/bin/date +\%Y-\%m-\%d)
```

- To restore the files
```
    cd /home/mphho/backups/config
    mv /etc/nginx/conf.d/mphho.conf /etc/nginx/conf.d/mphho.conf.COMPROMISED
    cp -r conf.d.mphho.conf.2023-07-18 /etc/nginx/conf.d/mphho.conf
    mv /etc/php/7.4/fpm/pool.d/mphho.conf /etc/php/7.4/fpm/pool.d/mphho.conf.COMPROMISED
    cp -r pool.d.mphho.conf.2023-07-18 /etc/php/7.4/fpm/pool.d/mphho.conf
    mv /etc/monit/monitrc /etc/monit/monitrc.COMPROMISED
    cp -r monitrc.2023-07-18 /etc/monit/monitrc
    mv /etc/monit.d /etc/monit.d.COMPROMISED
    cp -r monit.d.2023-07-18 /etc/monit.d
    mv /etc/letsencrypt /etc/letsencrypt.COMPROMISED
    cp -r letsencypt.2023-07-18 /etc/letsencrypt
    mv /etc/crontab /etc/crontab.COMPROMISED
    cp -r crontab.2023-07-18 /etc/crontab
```

## Online Azure backup
