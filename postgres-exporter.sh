#!/bin/bash

INSTALL_DIR=/u01
DATA_SOURCE_URI="localhost:5432/postgres?sslmode=disable"
DATA_SOURCE_USER=vagrant

wget https://github.com/prometheus-community/postgres_exporter/releases/download/v0.15.0/postgres_exporter-0.15.0.linux-amd64.tar.gz
tar xvf postgres_exporter-0.15.0.linux-amd64.tar.gz
mv ./postgres_exporter-0.15.0.linux-amd64/postgres_exporter $INSTALL_DIR
rm -rf postgres*

cat <<EOF > /etc/systemd/system/postgres_exporter.service
[Unit]
Description=Postgres Exporter
After=network.target

[Service]
Environment="DATA_SOURCE_URI=$DATA_SOURCE_URI"
Environment="DATA_SOURCE_USER=$DATA_SOURCE_USER"
ExecStart=$INSTALL_DIR/postgres_exporter

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now postgres_exporter.service
