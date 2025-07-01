# Menoetius v7.1 Docker Setup

This guide explains how to run Menoetius v7.1 using Docker, which provides a pre-configured environment with all necessary dependencies.

## Prerequisites

- Docker installed on your system
- Docker Compose (usually included with Docker Desktop)
- X11 server running (for GUI applications)
- Proper permissions to run Docker commands

## Quick Start

1. **Build the Docker image**:
   ```bash
   docker-compose build
   ```

2. **Run the container**:
   ```bash
   xhost +local:root  # Allow X11 connections from local root
   docker-compose up -d
   ```

3. **Access the container**:
   ```bash
   docker exec -it menoctius /bin/bash
   ```

4. **Run Menoetius**:
   ```bash
   sudo ./main.sh
   ```

## Important Notes

- The container runs with `--privileged` and `NET_ADMIN` capabilities to allow WiFi monitoring.
- X11 forwarding is enabled for GUI applications.
- The container runs as a non-root user `menouser` for security.
- All necessary tools (aircrack-ng, iw, etc.) are pre-installed.

## Stopping the Container

```bash
docker-compose down
xhost -local:root  # Reset X11 permissions
```

## Security Considerations

- Only use this tool on networks you own or have explicit permission to test.
- The container has elevated privileges - only run it from trusted sources.
- The default password for the `menouser` is `menopass` - change it for production use.

## Troubleshooting

- If you get X11 connection errors, ensure your X server allows connections from Docker containers.
- If WiFi devices aren't detected, ensure your host system has the necessary drivers and that the devices are properly passed through to the container.
