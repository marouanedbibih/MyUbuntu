#!/bin/bash

# Define log file
LOGFILE="/var/log/system_maintenance.log"

# Function to log messages
log_message() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOGFILE
}

# Start of the script
log_message "Starting system maintenance script."

# Update package lists
log_message "Updating package lists..."
sudo apt update >> $LOGFILE 2>&1

# Upgrade installed packages
log_message "Upgrading installed packages..."
sudo apt upgrade -y >> $LOGFILE 2>&1

# Remove unnecessary packages
log_message "Removing unnecessary packages..."
sudo apt autoremove -y >> $LOGFILE 2>&1

# Clean up local repository of retrieved package files
log_message "Cleaning up local repository of retrieved package files..."
sudo apt clean >> $LOGFILE 2>&1

# Rotate logs
log_message "Rotating logs..."
sudo logrotate /etc/logrotate.conf >> $LOGFILE 2>&1

# Optional: Check disk usage and report
log_message "Checking disk usage..."
df -h >> $LOGFILE 2>&1

# Optional: Check memory usage and report
log_message "Checking memory usage..."
free -h >> $LOGFILE 2>&1

# End of the script
log_message "System maintenance script completed."

# Notify user (optional, can be uncommented if you want email notifications)
# echo "System maintenance completed" | mail -s "System Maintenance Report" your-email@example.com

