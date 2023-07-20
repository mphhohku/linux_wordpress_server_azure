# packer limitation
sudo mv ~/nginx.conf /etc/nginx/nginx.conf
sudo systemctl reload nginx
sudo mv ~/wordpress_nginx.conf /etc/nginx/conf.d/mphhopackertest.conf
sudo mv ~/phppool.conf /etc/php/8.1/fpm/pool.d/www.conf
sudo mv /etc/php/8.1/fpm/php-fpm.conf /etc/php/8.1/fpm/php-fpm.conf.ORIG
sudo mv ~/php-fpm.conf /etc/php/8.1/fpm/php-fpm.conf
sudo mv /etc/php/8.1/fpm/php.ini /etc/php/8.1/fpm/php.ini.ORIG
sudo mv ~/php.ini /etc/php/8.1/fpm/php.ini

# TODO this command almost always fails in packer
# sudo systemctl restart php8.1-fpm

# TODO monit
# sudo mv ~/monitrc /etc/monit/monitrc
# sudo mv ~/monitd_mphhopackertest.conf /etc/monit.d/mphhopackertest.conf
# chmod 600 /usr/local/etc/monitrc
# service monit restart
# systemctl restart monit

# TODO SSH KEYGEN

# automate mysql_secure_installation
# TODO this is not working
# sudo mysql_secure_installation << EOF
