FROM frappe/erpnext-worker:v14

WORKDIR /home/frappe/frappe-bench

COPY entrypoint.sh /entrypoint.sh
COPY apps.txt /home/frappe/frappe-bench/apps.txt
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]