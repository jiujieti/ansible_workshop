#!/bin/bash

# Add entries from the Vagrant file to the /etc/hosts file

IFS=$'\n'
cat /vagrant/Vagrantfile |egrep "hostname|network" |awk 'NR%2{printf $0;next;}1' | tr -d "\"" | awk '{printf $7" "$3"\n"}' > /tmp/hosts
for LINE in `cat /tmp/hosts`
do
  IP=`echo $LINE |awk '{printf $1}'`
  FQDN=`echo $LINE |awk '{printf $2}'`
  SHORT=`echo $LINE |awk '{printf $2}'|cut -d "." -f 1`
  echo "${IP} ${SHORT} ${FQDN}" >> /etc/hosts
done
rm -f /tmp/hosts 

# Install Ansible on the server ansible

if [ "`hostname -s`" = "ansible" ]
then
  # Install ansible
  yum localinstall -y http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
  yum install -y --enablerepo=epel-testing ansible
  # Create an ssh key for the root account
  ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
  cp -p /root/.ssh/id_rsa.pub /vagrant/id_rsa.pub.ansible
  touch /root/.ssh/known_hosts
fi

# Copy the public key of the root account to the file authorized_keys
mkdir /root/.ssh/
if [ -e /vagrant/id_rsa.pub.ansible ]
then
  cat /vagrant/id_rsa.pub.ansible >> /root/.ssh/authorized_keys
fi
