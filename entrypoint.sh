#!/bin/bash

# This script is designed to run inside a Docker container to initialize and start ERPNext.

# Define the path to the site_config.json file
SITE_CONFIG_PATH="/home/frappe/frappe-bench/sites/site1.local/site_config.json"

echo "Starting ERPNext entrypoint script..."

# Check if the site_config.json file exists
if [ ! -f "$SITE_CONFIG_PATH" ]; then
    echo "Site configuration file not found at $SITE_CONFIG_PATH."
    echo "Creating a new ERPNext site: site1.local"
    echo "Using MariaDB root password: root"
    echo "Using Admin password: admin"
    echo "Installing ERPNext application..."

    # Run bench new-site command with specified parameters.
    # The --mariadb-root-password and --admin-password are provided for automated setup.
    # The --install-app erpnext ensures the ERPNext application is installed on the new site.
    bench new-site site1.local \
        --mariadb-root-password root \
        --admin-password admin \
        --install-app erpnext

    # Check the exit status of the previous command
    if [ $? -eq 0 ]; then
        echo "ERPNext site 'site1.local' created successfully."
    else
        echo "Error: Failed to create ERPNext site 'site1.local'."
        exit 1 # Exit with an error code if site creation fails
    fi
else
    echo "Site configuration file found at $SITE_CONFIG_PATH."
    echo "Skipping new site creation as 'site1.local' already exists."
fi

echo "Starting ERPNext services using bench start..."
# Start ERPNext services. This command will keep the container running.
# It's important that this is the last command in the script if it's the main process.
bench start

echo "ERPNext services started."
