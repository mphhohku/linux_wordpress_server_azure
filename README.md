# Hands-on Linux: Self-hosted WordPress for Linux Beginners

This is a repository of an adapation of the Udemy Course [Hands-on Linux: Self-Hosted WordPress for Linux Beginners](https://www.udemy.com/hands-on-linux-self-hosted-wordpress-for-linux-beginners/) specifically for Microsoft Azure. Grateful for Mr David Cohen's instructions.

You may view the WordPress site [here](https://www.mphho.com).

## Main features

Azure VM Setup
 - Using the cheapest Linux VM (B1s) with 1GB RAM

Linux setup
 - Nginx: with performance tuning (using previously set caching rules/compression in the gzip section in /etc/nginx/nginx.conf)
 - MySQL
 - PHP-fpm
 - WordPress

WordPress setup
 - no admin username in the air

Monitoring
 - Monit

HTTPS
 - Letsencrypt Certbot

Backup
 - Crontab
 - tar

## Reflections

Major hiccups and mitigation (I added my own notes in the respective sections)
- Section 0 - VM size malconfiguration: Use B1s instead of B1ls as 1GB RAM is required for the course
- Section 7 - WordPress malconfiguration: Use mysql commands to alter settings in the database when locked out of the web dashboard
- Section 8 - Unable to conduct SSH forwarding to Monit web portal: set up SSH key for default azure user first before using ssh tunneling
- Linux VM becomes slow and unresponsive after a weekend: restart the vm with sudo reboot

Future improvement
 - use mysqltuner after a week of use
 - automation using Hashicorp Packer
 - high availability