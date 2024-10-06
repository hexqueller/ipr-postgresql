#!/bin/bash

if [ "$(cat /etc/hostname)" == "pg01" ]; then
    # Установка
    rpm --import https://repo.liquibase.com/liquibase.asc
    yum-config-manager --add-repo https://repo.liquibase.com/repo-liquibase-com.repo
    yum install java-21-openjdk liquibase -y

    # Проливка
    git clone https://github.com/hexqueller/ipr-postgresql.git
    cd ipr-postgresql
    liquibase update
fi