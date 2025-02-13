# Monitoring with Monit

Edit the main config file at /etc/monit/monitrc

Content:

    set daemon  30
    set logfile /var/log/monit.log
    set alert mphhohku@outlook.com

    set httpd
        port 2812
        use address localhost  # only accept connection from localhost
        # allow localhost        # allow localhost to connect to the server and
        allow mphho:yourpassword # no plaintext password on GitHub

    # Check nginx
    # Try writing an nginx config using the other examples in this file!
    ## check process nginx with pidfile <yournginxpidfile>
    ## if failed...

    # Check MySQL
    check host localmysql with address 127.0.0.1
          if failed ping then alert        
          if failed port 3306 protocol mysql then alert

    # Check php-fpm
    check process phpfpm with pidfile /run/php/php7.4-fpm.pid
          if cpu > 50% for 2 cycles then alert
          # if total cpu > 60% for 5 cycles then restart
          if memory > 300 MB then alert
          # if total memory > 500 MB then restart


    # include files for individual sites
    include /etc/monit.d/*



That's your base file. Now, let's add some site files at /etc/monit.d/
For your first website, add a file named yoursitename.cnf, e.g. mphho.cnf

    # Site monitoring fragment for mphho.com
    check host mphho.com with address mphho.com
        if failed port 80 protocol http for 2 cycles then alert

    check file access.log with path /var/www/mphho/sites/mphho.com/error_log
        if size > 15 MB then exec "/usr/local/sbin/logrotate -f /var/www/mphho/sites/mphho.com/error_log"


After configuring appropriate access, restart monit and you should see it as active and running!
```
    chmod 600 /usr/local/etc/monitrc
    service monit restart
    systemctl restart monit
```

## Additional notes by mphho

Now logout root. Return to using the default azure user account.
```
    ssh-keygen -t ed25519
    cat /.ssh/id_ed25519.pub
    su - 
    nano /.ssh/authorized_keys
```

Copy the public key from the previous step and paste it into **a new line** of the authorized_keys file. Save and exit.
```
    chmod 600 /.ssh/authorized_keys
```

Conduct SSH forwarding to access the monit web portal on the localhost on the linux VM itself instead of the VM public IP address from the browser.
```
    ssh -L <customportnumber>:localhost:2812 azureuser@<yourpublicipaddress>
    netstat -tupln # You should see the custom port number you specified in the previous step listening SSH
    curl --user mphho:yourpassword http://localhost:<customportnumber> # You should be able to see the html of the monit web portal
```