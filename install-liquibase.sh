#!/bin/bash
DB_NAME=postgres
SQL=$(cat <<EOF
INSERT INTO students (name, created_at, "group") VALUES
('John Doe', '2023-10-01 10:00:00', 'Group A'),
('Jane Smith', '2023-10-02 11:00:00', 'Group B'),
('Alice Johnson', '2023-10-03 12:00:00', 'Group C'),
('Bob Brown', '2023-10-04 13:00:00', 'Group A');
EOF
)

if [ "$(cat /etc/hostname)" == "pg01" ]; then
    # Установка
    rpm --import https://repo.liquibase.com/liquibase.asc
    yum-config-manager --add-repo https://repo.liquibase.com/repo-liquibase-com.repo
    yum install java-21-openjdk liquibase -y

    # Проливка
    git clone https://github.com/hexqueller/ipr-postgresql.git
    cd ipr-postgresql
    liquibase update

    # Заполнение данными
    sudo -u vagrant env DB_NAME="$DB_NAME" SQL="$SQL" bash -c 'source /home/vagrant/.bashrc && /usr/local/pgsql/bin/psql -d "$DB_NAME" -c "$SQL"'
fi