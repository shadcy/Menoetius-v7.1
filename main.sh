#!/bin/bash

# AutoCrack - WiFi Testing Automation (For Educational and Authorized Use Only)

clear
echo "═══════════════════════════════════════════════════"
echo "           ⚡ AutoCrack - WiFi Test Utility ⚡"
echo "═══════════════════════════════════════════════════"
echo " Disclaimer: Unauthorized use of this tool is ILLEGAL."
echo " Use only on networks you own or have explicit permission for."
echo "═══════════════════════════════════════════════════"

read -p "Do you want to continue? [Y/N]: " var

if [[ "$var" != "Y" && "$var" != "y" ]]; then
    echo "Exiting. Stay safe."
    exit 0
fi

# Ensure running as root
if [[ $EUID -ne 0 ]]; then
    echo "Error: Please run this script with sudo."
    exit 1
fi

# Function to install missing packages
install_package() {
    pkg=$1
    if ! dpkg -s "$pkg" &> /dev/null; then
        echo "Package '$pkg' is not installed. Installing..."
        apt update
        apt install -y "$pkg"
    else
        echo "Package '$pkg' is already installed."
    fi
}

echo "Checking and installing required packages..."
install_package aircrack-ng
install_package iw

# Confirm required commands
for cmd in airmon-ng airodump-ng iwconfig; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is missing after install attempt. Aborting."
        exit 1
    fi
done

echo "═══════════════════════════════════════════════════"
echo "Available wireless interfaces:"
iw dev | grep Interface
echo "═══════════════════════════════════════════════════"

read -p "Enter your wireless interface (e.g., wlan0): " interface

if ! iw dev | grep -q "$interface"; then
    echo "Error: Interface $interface not found. Check your device name."
    exit 1
fi

echo "Killing conflicting processes..."
airmon-ng check kill

echo "Enabling monitor mode on $interface..."
airmon-ng start "$interface"

echo "═══════════════════════════════════════════════════"
echo "Current interfaces and monitor status:"
iwconfig
echo "═══════════════════════════════════════════════════"

read -p "Press Enter to start scanning for WiFi networks..."
airodump-ng "$interface"

echo "═══════════════════════════════════════════════════"
read -p "Enter the BSSID (MAC) of the target network: " BSSID
read -p "Enter the channel used by $BSSID: " Channel

# Basic BSSID validation
if ! [[ "$BSSID" =~ ^([A-Fa-f0-9]{2}:){5}[A-Fa-f0-9]{2}$ ]]; then
    echo "Error: Invalid BSSID format."
    exit 1
fi

if ! [[ "$Channel" =~ ^[0-9]+$ ]]; then
    echo "Error: Channel must be a number."
    exit 1
fi

echo "═══════════════════════════════════════════════════"
echo "Starting monitoring on BSSID $BSSID (Channel $Channel)..."
airodump-ng -w hack1 -c "$Channel" --bssid "$BSSID" "$interface"

echo "═══════════════════════════════════════════════════"
echo "Capture session ended. Check generated files."
echo "Stay ethical. Exiting."
