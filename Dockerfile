FROM frappe/erpnext-worker:v14

WORKDIR /home/frappe/frappe-bench

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]