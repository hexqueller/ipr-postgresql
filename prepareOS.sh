#!/bin/bash

echo "192.168.58.0  pg01" >> /etc/hosts
echo "192.168.58.1  pg01s" >> /etc/hosts

yum install vim -y