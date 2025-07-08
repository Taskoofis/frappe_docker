FROM frappe/erpnext-worker:v14

WORKDIR /home/frappe/frappe-bench

COPY apps.txt ./apps.txt
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["bash", "/entrypoint.sh"]