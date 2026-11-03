#!/bin/bash
# Linux Update & Cleanup Automation Script

LOG_FILE="$HOME/packages_cleaner.log"

echo "========== $(date '+%Y-%m-%d %H:%M:%S') ==========" >> "$LOG_FILE"

log(){
    echo -e "$1"
    echo -e "$1" >> "$LOG_FILE"
}


log '\n[INFO] Update sys package & upgrading packages list...'
sudo apt update && sudo apt upgrade -y >> "$LOG_FILE" 2>&1

log '\n[INFO] Removing unnecessary packages...'
sudo apt autoremove -y >> "$LOG_FILE" 2>&1

log '\n[INFO] Cleaning packages cache...'
sudo apt clean >> "$LOG_FILE" 2>&1

log "[INFO] Cleaning temporary files..."
rm -rf /tmp/* >> "$LOG_FILE" 2>&1
rm -rf /var/tmp/* >> "$LOG_FILE" 2>&1

# Optional: Notify user when done
if command -v notify-send &> /dev/null
then
    notify-send "Linux Cleanup Script" "Update and cleanup completed successfully!"
fi

log "[INFO] Update and cleanup completed!\n"
echo "==============================================" >> "$LOG_FILE"