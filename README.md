# Hands-on Linux: Self-hosted WordPress for Linux Beginners

Code and configuration snippets for the [Hands-on Linux: Self-Hosted WordPress for Linux Beginners Course](https://www.udemy.com/hands-on-linux-self-hosted-wordpress-for-linux-beginners/) course. 

Performance tuning
 - previously set caching rules/compression in the gzip section in /etc/nginx/nginx.conf
 - use mysqltuner after a week of use

Automation of configurations
 - coming soon

Monitoring

Reflections:

Major hiccups and mitigation
- VM size malconfiguration
- WordPress malconfiguration
- Linux VM becomes slow and unresponsive after a weekend: restart the vm with sudo reboot
- Unable to conduct SSH forwarding to Monit web portal: set up SSH key for default azure user first before using ssh tunneling

Future improvement