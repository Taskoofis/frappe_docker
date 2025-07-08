# Use a suitable base image. Python 3.9 is often used for Frappe/ERPNext.
# Using a slim-buster image to keep the image size down.
FROM frappe/erpnext-worker:v14

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies required for Frappe Bench and ERPNext
# This includes git, curl, build-essential, mariadb-client, redis-server, etc.
RUN apt-get update && \
    apt-get install -y \
    git \
    curl \
    build-essential \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    mariadb-client \
    redis-server \
    nginx \
    supervisor \
    # Add any other specific dependencies ERPNext might need, e.g., wkhtmltopdf
    # For wkhtmltopdf, you might need to download a specific version or use an apt repo
    # apt-get install -y wkhtmltopdf \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js and Yarn (required for Frappe frontend assets)
# Using NodeSource for a more recent Node.js version
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a dedicated user for Frappe
RUN useradd -m -s /bin/bash frappe

# Switch to the frappe user
USER frappe

# Set the working directory to the Frappe bench home
WORKDIR /home/frappe

# Install Frappe Bench CLI
RUN pip3 install frappe-bench

# Initialize a new Frappe Bench
# This creates the 'frappe-bench' directory and sets up the environment.
RUN bench init frappe-bench

# Change working directory to the newly created bench
WORKDIR /home/frappe/frappe-bench

# Install ERPNext into the bench
# This command adds the ERPNext app to the bench.
RUN bench get-app erpnext

# Copy your entrypoint.sh script into the container
# Ensure entrypoint.sh is in the same directory as your Dockerfile.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose the default ERPNext port
EXPOSE 8000

# Define the entrypoint for your Docker container
# The entrypoint script will handle site creation and starting services.
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Command to run when the container starts (can be overridden by ENTRYPOINT)
# This is often used for default commands if no ENTRYPOINT is set,
# or as a default argument to ENTRYPOINT.
CMD ["bench", "start"]