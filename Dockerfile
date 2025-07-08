# Use the official Frappe/ERPNext worker image as the base.
# This image already contains most of the necessary dependencies and the Frappe Bench environment.
FROM frappe/erpnext-worker:v14

# Set the working directory to the Frappe bench home.
# The base image typically sets this, but being explicit ensures consistency.
WORKDIR /home/frappe/frappe-bench

# Copy your entrypoint.sh script into a common executable path inside the container.
# Ensure entrypoint.sh is in the same directory as your Dockerfile.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable.
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose the default ERPNext port (8000).
# This is crucial for accessing the ERPNext web interface.
EXPOSE 8000

# Define the entrypoint for your Docker container.
# The entrypoint script will handle site creation (if needed) and starting ERPNext services.
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Define the default command to run when the container starts.
# This serves as a default argument to the ENTRYPOINT if no command is specified.
CMD ["bench", "start"]