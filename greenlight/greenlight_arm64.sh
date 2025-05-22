#!/usr/bin/env bash

# Set up basic app info
APPNAME="Greenlight"
APPDIR="/userdata/system/add-ons/${APPNAME,,}"
APPURL="https://github.com/batocera-unofficial-addons/batocera-unofficial-addons/releases/download/AppImages/greenlight.tar.xz"
ICONURL="https://github.com/batocera-unofficial-addons/batocera-unofficial-addons/raw/main/greenlight/extra/icon.png"
PORTIMG="https://github.com/batocera-unofficial-addons/batocera-unofficial-addons/raw/main/greenlight/extra/greenlight.png"

# Check for Xwayland
if ! pgrep -x "Xwayland" > /dev/null; then
    echo "Xwayland is not running. Exiting."
    exit 1
fi

echo "Xwayland detected. Installing ${APPNAME}..."
sleep 2

# Prepare install directory
rm -rf "${APPDIR}"
mkdir -p "${APPDIR}/greenlight" "${APPDIR}/extra" "${APPDIR}/home" "${APPDIR}/config" "${APPDIR}/roms"

# Download .tar.xz using wget
ARCHIVE="${APPDIR}/greenlight.tar.xz"
wget -q --show-progress -O "$ARCHIVE" "$APPURL"

# Extract it into greenlight subdir
tar -xJf "$ARCHIVE" -C "${APPDIR}"
rm -f "$ARCHIVE"

# Make sure main binary is executable (if applicable)
chmod +x "${APPDIR}/greenlight/greenlight" 2>/dev/null
chmod +x "${APPDIR}/greenlight/run.sh" 2>/dev/null

# Download icons
curl -s -L -o "${APPDIR}/extra/icon.png" "$ICONURL"

# Create launcher script
cat <<EOF > "${APPDIR}/Launcher"
#!/bin/bash
batocera-mouse show
HOME="${APPDIR}/home" \\
XDG_CONFIG_HOME="${APPDIR}/config" \\
QT_SCALE_FACTOR="1" \\
GDK_SCALE="1" \\
XDG_DATA_HOME="${APPDIR}/home" \\
DISPLAY=:0.0 \\
"${APPDIR}/greenlight/run.sh" --no-sandbox "\$@"
EOF

chmod +x "${APPDIR}/Launcher"

# Create F1 Applications shortcut
DESKTOP="${APPDIR}/extra/${APPNAME,,}.desktop"
cat <<EOF > "$DESKTOP"
[Desktop Entry]
Version=1.0
Name=${APPNAME}
Exec=${APPDIR}/Launcher
Icon=${APPDIR}/extra/icon.png
Terminal=false
Type=Application
Categories=Game;batocera.linux;
EOF

chmod +x "$DESKTOP"
cp "$DESKTOP" "/usr/share/applications/${APPNAME,,}.desktop" 2>/dev/null

# Create PORTS launcher
PORT_LAUNCHER="/userdata/roms/ports/${APPNAME}.sh"
cat <<EOF > "$PORT_LAUNCHER"
#!/bin/bash
killall -9 ${APPNAME,,} 2>/dev/null
batocera-mouse show
${APPDIR}/Launcher
EOF

chmod +x "$PORT_LAUNCHER"

# Create controller keys mapping
cat <<EOF > "${PORT_LAUNCHER}.keys"
{
    "actions_player1": [
        {
            "trigger": [
                "hotkey",
                "start"
            ],
            "type": "key",
            "target": [
                "KEY_LEFTALT",
                "KEY_F4"
            ]
        }
    ]
}
EOF

# Autostart integration
STARTUP_SCRIPT="${APPDIR}/extra/startup"
echo "#!/bin/bash" > "$STARTUP_SCRIPT"
echo "cp \"$DESKTOP\" /usr/share/applications/ 2>/dev/null" >> "$STARTUP_SCRIPT"
chmod +x "$STARTUP_SCRIPT"

CUSTOM_SH="/userdata/system/custom.sh"
grep -qxF "$STARTUP_SCRIPT" "$CUSTOM_SH" 2>/dev/null || echo "$STARTUP_SCRIPT" >> "$CUSTOM_SH"
chmod +x "$CUSTOM_SH"

# Step 5: Refresh the Ports menu
echo "Refreshing Ports menu..."
curl http://127.0.0.1:1234/reloadgames

# Download the image
echo "Downloading Greenlight logo..."
curl -L -o /userdata/roms/ports/images/greenlight.png https://github.com/batocera-unofficial-addons/batocera-unofficial-addons/raw/main/greenlight/extra/greenlight.png
echo "Adding logo to Greenlight entry in gamelist.xml..."
xmlstarlet ed -s "/gameList" -t elem -n "game" -v "" \
  -s "/gameList/game[last()]" -t elem -n "path" -v "./Greenlight.sh" \
  -s "/gameList/game[last()]" -t elem -n "name" -v "Greenlight" \
  -s "/gameList/game[last()]" -t elem -n "image" -v "./images/greenlight.png" \
  /userdata/roms/ports/gamelist.xml > /userdata/roms/ports/gamelist.xml.tmp && mv /userdata/roms/ports/gamelist.xml.tmp /userdata/roms/ports/gamelist.xml
  
curl http://127.0.0.1:1234/reloadgames

echo "${APPNAME} installed and available under Ports and Applications!"
sleep 3
exit 0
