# Step 1: Fetch the latest release of Moonlight AppImage
echo "Fetching the latest Moonlight AppImage release..."
latest_release_url=$(curl -s https://api.github.com/repos/moonlight-stream/moonlight-qt/releases/latest | grep "browser_download_url" | grep "AppImage" | cut -d '"' -f 4)

if [ -z "$latest_release_url" ]; then
    echo "Failed to retrieve the latest Moonlight release URL."
    exit 1
fi

# Step 2: Download the AppImage
echo "Downloading Moonlight AppImage from $latest_release_url..."
mkdir -p /userdata/system/add-ons/moonlight
wget -q -O /userdata/system/add-ons/moonlight/moonlight.AppImage "$latest_release_url"

if [ $? -ne 0 ]; then
    echo "Failed to download the Moonlight AppImage."
    exit 1
fi

chmod a+x /userdata/system/add-ons/moonlight/moonlight.AppImage
echo "Moonlight AppImage downloaded and marked as executable."


# Create persistent configuration and log directories
mkdir -p /userdata/system/add-ons/moonlight/moonlight-config
mkdir -p /userdata/system/logs

# Step 2: Create the Moonlight Launcher Script
echo "Creating Moonlight launcher in Ports..."
mkdir -p /userdata/roms/ports
cat << 'EOF' > /userdata/roms/ports/Moonlight.sh
#!/bin/bash

# Environment setup
export $(cat /proc/1/environ | tr '\0' '\n')
export DISPLAY=:0.0
export HOME=/userdata/system/add-ons/moonlight

# Directories and file paths
app_dir="/userdata/system/add-ons/moonlight"
config_dir="${app_dir}/moonlight-config"
config_symlink="${HOME}/.config/moonlight"
app_image="${app_dir}/moonlight.AppImage"
log_dir="/userdata/system/logs"
log_file="${log_dir}/moonlight.log"

# Ensure log directory exists
mkdir -p "${log_dir}"

# Append all output to the log file
exec &> >(tee -a "$log_file")
echo "$(date): Launching Moonlight"

# Create persistent directory for Moonlight config
mkdir -p "${config_dir}"

# Move existing config if present
if [ -d "${config_symlink}" ] && [ ! -L "${config_symlink}" ]; then
    mv "${config_symlink}" "${config_dir}"
fi

# Ensure config directory is symlinked
if [ ! -L "${config_symlink}" ]; then
    ln -sf "${config_dir}" "${config_symlink}"
fi

# Launch Moonlight AppImage
if [ -x "${app_image}" ]; then
    cd "${app_dir}"
    ./moonlight.AppImage > "${log_file}" 2>&1
    echo "Moonlight exited."
else
    echo "Moonlight.AppImage not found or not executable."
    exit 1
fi
EOF

chmod +x /userdata/roms/ports/Moonlight.sh

echo "Refreshing Ports menu..."
curl http://127.0.0.1:1234/reloadgames

# Download the image
echo "Downloading Moonlight logo..."
curl -L -o /userdata/roms/ports/images/moonlightlogo.png https://github.com/batocera-unofficial-addons/batocera-unofficial-addons/raw/main/moonlight/extra/moonlightlogo.png

echo "Adding logo to Moonlight entry in gamelist.xml..."
xmlstarlet ed -s "/gameList" -t elem -n "game" -v "" \
  -s "/gameList/game[last()]" -t elem -n "path" -v "./Moonlight.sh" \
  -s "/gameList/game[last()]" -t elem -n "name" -v "Moonlight" \
  -s "/gameList/game[last()]" -t elem -n "image" -v "./images/moonlightlogo.png" \
  /userdata/roms/ports/gamelist.xml > /userdata/roms/ports/gamelist.xml.tmp && mv /userdata/roms/ports/gamelist.xml.tmp /userdata/roms/ports/gamelist.xml


curl http://127.0.0.1:1234/reloadgames

echo
echo "Installation complete! You can now launch Moonlight from the Ports menu."
