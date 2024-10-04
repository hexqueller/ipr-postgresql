#!/bin/bash

# Утилиты для сборки
yum install git make gcc tar gzip bzip2 flex perl readline-devel zlib-devel pkgconfig libicu-devel bison -y

git config --global http.version HTTP/1.1 # Фикс ошибки HTTP2
git clone https://git.postgresql.org/git/postgresql.git
cd postgresql
./configure

make
make install

sudo mkdir -p /usr/local/pgsql/data
sudo chown vagrant /usr/local/pgsql/data

echo 'export PATH=/usr/local/pgsql/bin:$PATH' >> /home/vagrant/.bashrc
echo 'export PGDATA=/usr/local/pgsql/data' >> /home/vagrant/.bashrc

# Инициализация базы на мастере
if [ "$(cat /etc/hostname)" == "pg01" ]; then
    sudo -u vagrant bash -c 'source /home/vagrant/.bashrc && /usr/local/pgsql/bin/initdb -U vagrant -k -D /usr/local/pgsql/data'
fi
