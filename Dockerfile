FROM frappe/erpnext-worker:v14

USER root

WORKDIR /home/frappe/frappe-bench

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER frappe

ENTRYPOINT ["/entrypoint.sh"]
