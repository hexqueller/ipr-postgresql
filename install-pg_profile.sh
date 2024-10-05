#!/bin/bash

DB_NAME="postgres"

CREATE_dblink="create extension dblink;"
CREATE_pg_stat_statements="create extension pg_stat_statements;"

CREATE_schema_pg_profile="CREATE SCHEMA profile;"
CREATE_pg_profile="CREATE EXTENSION pg_profile SCHEMA profile;"

if [ "$(cat /etc/hostname)" == "pg01" ]; then
    wget https://github.com/zubkov-andrei/pg_profile/releases/download/4.7/pg_profile--4.7.tar.gz
    tar xzf pg_profile--4.7.tar.gz --directory $(/usr/local/pgsql/bin/pg_config --sharedir)/extension
    rm -rf pg_profile--4.7.tar.gz
    sudo -u vagrant env DB_NAME="$DB_NAME" CREATE_dblink="$CREATE_dblink" bash -c 'source /home/vagrant/.bashrc && /usr/local/pgsql/bin/psql -d "$DB_NAME" -c "$CREATE_dblink"'
    sudo -u vagrant env DB_NAME="$DB_NAME" CREATE_pg_stat_statements="$CREATE_pg_stat_statements" bash -c 'source /home/vagrant/.bashrc && /usr/local/pgsql/bin/psql -d "$DB_NAME" -c "$CREATE_pg_stat_statements"'
    sudo -u vagrant env DB_NAME="$DB_NAME" CREATE_schema_pg_profile="$CREATE_schema_pg_profile" bash -c 'source /home/vagrant/.bashrc && /usr/local/pgsql/bin/psql -d "$DB_NAME" -c "$CREATE_schema_pg_profile"'
    sudo -u vagrant env DB_NAME="$DB_NAME" CREATE_pg_profile="$CREATE_pg_profile" bash -c 'source /home/vagrant/.bashrc && /usr/local/pgsql/bin/psql -d "$DB_NAME" -c "$CREATE_pg_profile"'
fi
