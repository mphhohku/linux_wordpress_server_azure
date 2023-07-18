## Additional notes by mphho

### What to back up
1. Application files
- /home/mphho

2. Configuration files
- /etc/nginx/conf.d/mphho.conf
- /etc/php/7.4/fpm/pool.d/mphho.conf
- /etc/monit/monitrc
- /etc/monit.d
- /etc/letsencrypt

3. Application state
- MySQL database dump
- WordPress

### offline backup

Backing up the filesystem:
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

Add the following line to the end of the file:
```
    0 0 * * * root usr/bin/tar -zcf /root/site_backups/mphho-$(/bin/date +\%Y-\%m-\%d).tar.gz --absolute-names /home/mphho
```

When needed to restore:
```
    # switch to root
    su -

    # restore
    mv /home/mphho/public_html /home/mphho/public_html.COMPROMISED
    cd /root/site_backups
    tar -zxf /root/site_backups/mphho-2023-07-08.tar.gz
    cp home/mphho/public_html /home/mphho/public_html
```

### online Azure backup
