# WiFi Testing Tool GUI

A user-friendly graphical interface for WiFi testing tools, providing an easy way to scan for networks and perform deauthentication attacks (for educational and authorized use only).

## Features

- **WiFi Scanner**: Scan for nearby wireless networks and view detailed information
- **Monitor Mode**: Monitor a specific network for connected clients
- **Deauthentication Attack**: Perform deauthentication attacks on target networks
- **Real-time Output**: View command output in real-time within the application

## Prerequisites

- Python 3.x
- Tkinter (usually included with Python)
- Aircrack-ng suite
- Root privileges (required for monitor mode and packet injection)

## Installation

1. Install the required dependencies:

```bash
sudo apt update
sudo apt install python3-tk aircrack-ng
```

2. Make the script executable:
```bash
chmod +x wifi_tool_gui.py
```

## Usage

1. Run the application with root privileges:
```bash
sudo ./wifi_tool_gui.py
```

2. Use the interface to:
   - Select your wireless interface
   - Scan for available networks
   - Monitor a specific network
   - Perform deauthentication attacks

## Legal Notice

This tool is provided for educational and authorized penetration testing purposes only. Unauthorized use of this tool against networks you don't own or have explicit permission to test is illegal. The authors and contributors are not responsible for any misuse or damage caused by this tool.

## License

This project is for educational purposes only.
