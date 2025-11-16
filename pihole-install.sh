#!/usr/bin/env bash
set -euo pipefail

echo "=== Pi-hole installer helper ==="

if [[ "$(id -u)" -ne 0 ]]; then
  echo "This script must be run as root (use sudo)." >&2
  exit 1
fi

export DEBIAN_FRONTEND=noninteractive

echo "Updating package lists..."
apt-get update -y

echo "Upgrading existing packages (safe defaults)..."
apt-get upgrade -y

echo "Installing required dependencies (curl, ca-certificates)..."
apt-get install -y curl ca-certificates

echo
echo "Downloading official Pi-hole installer..."
curl -sSL https://install.pi-hole.net -o /tmp/basic-install.sh
chmod +x /tmp/basic-install.sh

echo
echo "Running Pi-hole installer (interactive)..."
echo "You will be asked to choose interface, IP, upstream DNS, etc."
echo

bash /tmp/basic-install.sh

echo
echo "=== Pi-hole installation finished (if no errors above). ==="
echo "Open the web UI at:  http://pi.hole/admin/  or  http://<your-pihole-ip>/admin/"
