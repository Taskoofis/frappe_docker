#!/bin/bash

# Yeni site varsa kurulum yap
if [ ! -f "/home/frappe/frappe-bench/sites/site1.local/site_config.json" ]; then
  echo "Yeni ERPNext sitesi kuruluyor..."

  bench new-site site1.local \
    --mariadb-root-password=root \
    --admin-password=admin \
    --install-app erpnext

  echo "Kurulum tamamlandı"
fi

# Sunucuyu başlat
echo "ERPNext başlatılıyor..."
bench start