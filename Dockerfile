# Frappe için temel image
FROM frappe/erpnext-worker:version-14

# Çalışma dizinini ayarla
WORKDIR /home/frappe/frappe-bench

# Portu dışa aç
EXPOSE 8000

CMD ["bench", "start"]