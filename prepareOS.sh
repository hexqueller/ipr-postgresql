#!/bin/bash

# /etc/hosts
echo "10.0.0.99  pg01" >> /etc/hosts
echo "10.0.0.98  pg01s" >> /etc/hosts

# Удобный софт
yum install vim wget -y

# Disable SELINUX
setenforce 0 # До перезагрузки
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config # После перезагрузки