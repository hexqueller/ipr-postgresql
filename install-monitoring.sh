#!/bin/bash

INSTALL_DIR=/u01

mkdir -p $INSTALL_DIR/victoria-metrics-data
chown -R vagrant $INSTALL_DIR

# Install Victoria Metrics
if [ "$(cat /etc/hostname)" == "pg01" ]; then
    wget https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/v1.104.0/victoria-metrics-linux-amd64-v1.104.0.tar.gz
    tar xvf victoria-metrics-linux-amd64-v1.104.0.tar.gz
    mv victoria-metrics-prod $INSTALL_DIR
    rm -rf victoria-metrics-linux-amd64-v1.104.0.tar.gz
    cat <<EOF > /etc/systemd/system/victoriametrics.service
[Unit]
Description=VictoriaMetrics
After=network.target

[Service]
ExecStart=$INSTALL_DIR/victoria-metrics-prod -storageDataPath=$INSTALL_DIR/victoria-metrics-data/ -httpListenAddr=0.0.0.0:8428 -retentionPeriod=1

[Install]
WantedBy=multi-user.target
EOF
fi


# Install and configure VMagent
if [ "$(cat /etc/hostname)" == "pg01" ]; then
    wget https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/v1.104.0/vmutils-linux-amd64-v1.104.0.tar.gz
    tar xvf vmutils-linux-amd64-v1.104.0.tar.gz
    mv vmagent-prod $INSTALL_DIR
    rm -rf vm*
    cat <<EOF > /etc/systemd/system/vmagent.service
[Unit]
Description=VMagent
After=network.target

[Service]
ExecStart=$INSTALL_DIR/vmagent-prod -promscrape.config=$INSTALL_DIR/vmagent.yaml -remoteWrite.url=http://pg01:8428/api/v1/write -promscrape.config.strictParse=false
Restart=always

[Install]
WantedBy=multi-user.target
EOF
    cat <<EOF > $INSTALL_DIR/vmagent.yaml
global:
  scrape_interval: 5s

scrape_configs:
  - job_name: postgres_exporter
    static_configs:
      - targets:
          - pg01:9187
          - pg01s:9187
EOF
fi

# Install Grafana server
if [ "$(cat /etc/hostname)" == "pg01" ]; then
    sudo yum install -y https://dl.grafana.com/oss/release/grafana-11.2.2-1.x86_64.rpm chkconfig
    mkdir -p /etc/grafana/provisioning/datasources
    cat <<EOF > /etc/grafana/provisioning/datasources/datasource.yml
apiVersion: 1

datasources:
  - name: VictoriaMetrics
    type: prometheus
    access: proxy
    url: http://localhost:8428
    isDefault: true
EOF
  cd $INSTALL_DIR
  wget -O $INSTALL_DIR/postgresql.json https://grafana.com/api/dashboards/9628/revisions/7/download
    cat <<EOF > /etc/grafana/provisioning/dashboards/dashboard.yml
apiVersion: 1
providers:
- name: 'postgresql'
  orgId: 1
  folder: ''
  type: file
  disableDeletion: false
  updateIntervalSeconds: 10 
  options:
    path: $INSTALL_DIR/postgresql.json 
EOF
fi

# Start all daemons
if [ "$(cat /etc/hostname)" == "pg01" ]; then
    systemctl daemon-reload
    systemctl enable --now victoriametrics.service
    systemctl enable --now vmagent.service
    systemctl enable --now grafana-server
fi