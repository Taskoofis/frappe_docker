FROM frappe/erpnext-worker:v14

# Çalışma dizinine geç
WORKDIR /home/frappe/frappe-bench

# entrypoint.sh dosyasını kopyala
COPY entrypoint.sh /entrypoint.sh

# Çalıştırılabilir yap
RUN chmod +x /entrypoint.sh

RUN ls -la /

# Giriş noktası olarak scripti kullan
ENTRYPOINT ["/entrypoint.sh"]
