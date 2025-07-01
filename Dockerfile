FROM kalilinux/kali-rolling

# Update and install required packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    aircrack-ng \
    iw \
    wireless-tools \
    net-tools \
    procps \
    python3 \
    python3-tk \
    xterm \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Copy application files
COPY . /app
WORKDIR /app

# Make scripts executable
RUN chmod +x main.sh exe.sh

# Set environment variables
ENV DISPLAY=:0

# Create a non-root user
RUN useradd -m menouser && \
    usermod -aG sudo menouser && \
    echo 'menouser:menopass' | chpasswd

# Switch to non-root user
USER menouser

# Entry point
ENTRYPOINT ["/bin/bash"]
