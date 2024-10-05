#!/bin/bash

# postgresql.conf
echo "wal_level = replica" >> /usr/local/pgsql/data/postgresql.conf
echo "max_wal_senders = 10" >> /usr/local/pgsql/data/postgresql.conf
echo "wal_keep_size = 64" >> /usr/local/pgsql/data/postgresql.conf
echo "listen_addresses = '*'" >> /usr/local/pgsql/data/postgresql.conf

# pg_hba.conf
echo "host    replication     all             10.0.0.98/32            trust" >> /usr/local/pgsql/data/pg_hba.conf
echo "host    all             vagrant         10.0.0.2/32             trust" >> /usr/local/pgsql/data/pg_hba.conf

# Standby
if [ "$(cat /etc/hostname)" == "pg01s" ]; then
  rm -rf /usr/local/pgsql/data
  mkdir -p /usr/local/pgsql/data
  /usr/local/pgsql/bin/pg_basebackup -h 10.0.0.99 -D /usr/local/pgsql/data -U vagrant -v -P --wal-method=stream
  chown -R vagrant /usr/local/pgsql/data
  chmod 750 /usr/local/pgsql/data
  echo "hot_standby = on" >> /usr/local/pgsql/data/postgresql.conf
  echo "primary_conninfo = 'host=pg01 port=5432 user=vagrant'" >> /usr/local/pgsql/data/postgresql.conf
  touch /usr/local/pgsql/data/standby.signal
fi

# Start PostgreSQL
sudo -u vagrant bash -c 'source /home/vagrant/.bashrc && /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l /home/vagrant/logfile start'