#!/bin/bash

# Update and install prerequisites
sudo apt-get update
sudo apt-get install -y curl git python3 python3-pip

# Clone the panel repository
PANEL_DIR="/opt/management-panel"
REPO_URL="https://github.com/siavashdeve/management-panel.git"

if [ -d "$PANEL_DIR" ]; then
    echo "Panel directory already exists. Updating..."
    cd "$PANEL_DIR"
    git pull origin main
else
    echo "Cloning panel repository..."
    git clone "$REPO_URL" "$PANEL_DIR"
    cd "$PANEL_DIR"
fi

# Install Python dependencies
if [ -f "requirements.txt" ]; then
    pip3 install -r requirements.txt
else
    echo "requirements.txt not found. Skipping Python dependencies."
fi

# Create a systemd service for the panel
SERVICE_FILE="/etc/systemd/system/management-panel.service"
cat <<EOF | sudo tee "$SERVICE_FILE" > /dev/null
[Unit]
Description=Management Panel Web Interface
After=network.target

[Service]
User=root
WorkingDirectory=$PANEL_DIR
ExecStart=/usr/bin/python3 $PANEL_DIR/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start the service
sudo systemctl daemon-reload
sudo systemctl start management-panel
sudo systemctl enable management-panel

echo "Panel installed and started successfully!"
echo "Access the panel at http://your-server-ip:5000"