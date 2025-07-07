#!/bin/bash

set -e

cd /home/frappe/frappe-bench

# Yeni site varsa kurulum yap
if [ ! -f "sites/site1.local/site_config.json" ]; then
  echo "Yeni ERPNext sitesi kuruluyor..."

  bench new-site site1.local \
    --mariadb-root-password=root \
    --admin-password=admin \
    --install-app erpnext

  echo "Kurulum tamamlandı"
fi

# Sunucuyu başlat
echo "ERPNext başlatılıyor..."
exec bench start
