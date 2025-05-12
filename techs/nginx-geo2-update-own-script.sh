#!/bin/bash

# === Configuration ===
LICENSE_KEY="PUT_YOUR_MAXMIND_LICENSE_KEY_HERE"
DEST_DIR="/etc/nginx/geoip2"
TMP_DIR="/tmp/geoip2"
COUNTRY_EDITION="GeoLite2-Country"
CITY_EDITION="GeoLite2-City"

# Start fresh
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR" "$DEST_DIR"

echo "Starting GeoIP2 update at $(date)"

# Download Country DB
echo "Downloading Country DB..."
wget -q "https://download.maxmind.com/app/geoip_download?edition_id=$COUNTRY_EDITION&license_key=$LICENSE_KEY&suffix=tar.gz" -O "$TMP_DIR/${COUNTRY_EDITION}.tar.gz" || {
    echo "❌ Failed to download $COUNTRY_EDITION"
    exit 1
}

# Download City DB
echo "Downloading City DB..."
wget -q "https://download.maxmind.com/app/geoip_download?edition_id=$CITY_EDITION&license_key=$LICENSE_KEY&suffix=tar.gz" -O "$TMP_DIR/${CITY_EDITION}.tar.gz" || {
    echo "❌ Failed to download $CITY_EDITION"
    exit 1
}

# Extract databases
echo "Extracting databases..."
tar -xzf "$TMP_DIR/${COUNTRY_EDITION}.tar.gz" -C "$TMP_DIR"
cp "$TMP_DIR"/${COUNTRY_EDITION}_*/${COUNTRY_EDITION}.mmdb "$DEST_DIR/"

tar -xzf "$TMP_DIR/${CITY_EDITION}.tar.gz" -C "$TMP_DIR"
cp "$TMP_DIR"/${CITY_EDITION}_*/${CITY_EDITION}.mmdb "$DEST_DIR/"

# Cleanup
rm -rf "$TMP_DIR"

# Test NGINX configuration
echo "Testing NGINX config..."
if nginx -t; then
    echo "✅ NGINX config is valid. Reloading..."
    systemctl reload nginx
    echo "✅ NGINX reloaded successfully."
else
    echo "❌ NGINX config test failed. Reload skipped."
    exit 2
fi
