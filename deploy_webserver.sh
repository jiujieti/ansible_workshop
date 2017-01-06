#!/bin/bash

# Install httpd
yum list installed | grep ^httpd.x86_64 > /dev/null || yum -q -y install httpd
[ $? -eq 0 ] && echo "[ OK ] httpd installlation" || { echo "[ ERROR ] httpd installation"; exit 1; }

# Add content to the webserver
echo "Hello World!" > /var/www/html/index.html && echo "[ OK ] content added" || { echo "[ ERROR ] content added"; exit 1; }

# Start the webserver
service httpd status > /dev/null || service httpd start > /dev/null
[ $? -eq 0 ] && echo "[ OK ] service httpd starting" || { echo "[ ERROR ] Service httpd starting"; exit 1; }

# Enable the webserver at boot
chkconfig httpd --list | grep -q 3:on || chkconfig httpd on
[ $? -eq 0 ] && echo "[ OK ] httpd starting at boot" || { echo "[ ERROR ] httpd not starting at boot"; exit 1; }
