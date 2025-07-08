# Use an appropriate base image for ERPNext, e.g., a Python or Ubuntu image
FROM frappe/erpnext-worker:v14

# Set the working directory inside the container
WORKDIR /home/frappe/frappe-bench

# Copy your entrypoint.sh script into the container
# Make sure entrypoint.sh is in the same directory as your Dockerfile,
# or adjust the source path accordingly.
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Define the entrypoint for your Docker container
ENTRYPOINT ["/entrypoint.sh"]

# Expose any necessary ports (e.g., for ERPNext web access)
EXPOSE 8000

# Add any other necessary commands to install ERPNext dependencies,
# bench, etc., before the entrypoint script runs.
# For example:
# RUN apt-get update && apt-get install -y ...
# RUN pip install frappe-bench