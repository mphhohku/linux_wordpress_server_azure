# Hands-on Linux: Self-hosted WordPress for Linux Beginners (Azure Edition)

This is an adapation of the Udemy Course [Hands-on Linux: Self-Hosted WordPress for Linux Beginners](https://www.udemy.com/hands-on-linux-self-hosted-wordpress-for-linux-beginners/) by Mr David Cohen. The content and instructions are tweaked for deployment in the Microsoft Azure environment.

You may view my WordPress site [here](https://www.mphho.com).

Using HashiCorp Packer, an image of the Linux VM (Sections 1 to 7, just before installation of WordPress due to limitation of mysql-secure-installation) can be created automatically on Azure. The instructions are in the [11-automate-packer.md](11-automate-packer.md) file.

I used GitHub Copilot to help me build this project and make documentation.

## Main features

Azure VM Setup
 - Using the cheapest Linux VM (B1s) with 1GB RAM, 10 USD budget per month

Linux setup
 - Nginx: with performance tuning (using previously set caching rules/compression in the gzip section in /etc/nginx/nginx.conf)
 - MySQL
 - PHP-FPM
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

Automation
 - HashiCorp Packer

## Reflections

Major hiccups and mitigation (I added my own notes in the respective sections)
- Section 0 - VM size malconfiguration: Use B1s instead of B1ls as 1GB RAM is required for the course
- Section 7 - WordPress malconfiguration: Use mysql commands to alter settings in the database when locked out of the web dashboard
- Section 8 - Unable to conduct SSH forwarding to Monit web portal: set up SSH key for default azure user first before using ssh tunneling
- Section 10 - Needed to reset MySQL root password: follow the instructions online
- Section 13 - Debugging: quite minor, sometimes Packer can be quite frustrating to debug because it can even fail at apt update even with sudo access. The only thing that can be done is to wait for everything to be deleted and retry.
- Linux VM becomes slow and unresponsive after a weekend: restart the vm with sudo reboot

Future improvement
 - use mysqltuner after a week of use
 - high availability