#!/bin/bash

echo "wal_level = replica" >> /usr/local/pgsql/data/postgresql.conf
echo "max_wal_senders = 10" >> /usr/local/pgsql/data/postgresql.conf
echo "wal_keep_size = 64" >> /usr/local/pgsql/data/postgresql.conf
echo "listen_addresses = '*'" >> /usr/local/pgsql/data/postgresql.conf

echo "host    replication     all             192.168.58.1/32            trust" >> /usr/local/pgsql/data/pg_hba.conf

if [ "$(cat /etc/hostname)" == "pg01s" ]; then
  rm -rf /usr/local/pgsql/data
  mkdir -p /usr/local/pgsql/data
  /usr/local/pgsql/bin/pg_basebackup -h 192.168.58.0 -D /usr/local/pgsql/data -U vagrant -v -P --wal-method=stream
  chown -R vagrant /usr/local/pgsql/data
  chmod 750 /usr/local/pgsql/data
  echo "hot_standby = on" >> /usr/local/pgsql/data/postgresql.conf
  echo "primary_conninfo = 'host=192.168.58.0 port=5432 user=vagrant'" >> /usr/local/pgsql/data/postgresql.conf
  touch /usr/local/pgsql/data/standby.signal
fi

sudo -u vagrant bash -c 'source /home/vagrant/.bashrc && /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start'