#!/bin/bash

# Set the application name
APPNAME="Arch KDE"

# Base directory for Arch KDE data
data_dir="/userdata/system/add-ons/${APPNAME,,}"

# Function to check if a port is in use
is_port_in_use() {
    lsof -i:$1 &> /dev/null
}

# Function to find the next available port starting from 3000
find_available_port() {
    local start_port=3000
    local port=$start_port

    # Get a list of all host ports used by Docker (running or not)
    local used_ports=$(docker ps -a --format '{{.Ports}}' | grep -oP '\d+(?=->)' | sort -u)

    while :; do
        if ! echo "$used_ports" | grep -q "^$port$" && ! lsof -i:"$port" &> /dev/null; then
            echo "$port"
            return
        fi
        port=$((port + 1))
    done
}


# Dynamically get the next free port
HOST_PORT=$(find_available_port)

# Check for Docker and install if missing
if ! command -v docker &> /dev/null || ! docker info &> /dev/null; then
    dialog --title "Docker Required" --infobox "Docker is not installed or the service is not running. Installing Docker..." 10 50
    curl -fsSL https://github.com/batocera-unofficial-addons/batocera-unofficial-addons/raw/refs/heads/main/docker/docker.sh | bash

    if ! command -v docker &> /dev/null || ! docker info &> /dev/null; then
        dialog --title "Docker Error" --msgbox "Docker installation failed or the service did not start. Please install Docker manually." 10 50
        clear
        exit 1
    fi
fi

# Create Arch KDE data and home directories
mkdir -p "$data_dir"
mkdir -p "$data_dir/home"

# Start Arch KDE Docker container
dialog --title "Starting ${APPNAME}" --infobox "Launching ${APPNAME} (Webtop - KDE) using Docker..." 10 50
docker run -d \
  --name=arch-kde \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e TZ=$(cat /etc/timezone) \
  -e SUBFOLDER=/ \   
  -p ${HOST_PORT}:3000 \
  -v "$data_dir:/config" \
  -v "$data_dir/home:/home/ubuntu" \
  --shm-size="2gb" \
  --restart unless-stopped \
  lscr.io/linuxserver/webtop:arch-kde

# Final message
if docker ps -q -f name=arch-kde &> /dev/null; then
    MSG="${APPNAME} container has been started successfully.\n\nAccess it via: http://<your-ip>:${HOST_PORT}"
else
    MSG="Failed to start ${APPNAME}. Please check Docker logs for troubleshooting."
fi

dialog --title "${APPNAME} Setup" --msgbox "$MSG" 20 70
clear
