# WARNING: Google chrome not working here

# Start from a base Ubuntu image
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Set password for the existing vscode user
RUN echo "vscode:vscode" | chpasswd

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    tilix \
    openbox \
    xrdp \
    wget \
    fonts-liberation \
    libasound2 \
    libnspr4 \
    libnss3 \
    xdg-utils \
    libgconf-2-4 && \
    rm -rf /var/lib/apt/lists/*

# Download and install Google Chrome
RUN mkdir -p /home/vscode/Downloads && \
    wget -P /home/vscode/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i /home/vscode/Downloads/google-chrome-stable_current_amd64.deb && \
    apt-get install -f && \
    rm -rf /home/vscode/Downloads

# Configure xrdp
RUN echo "xrdp xrdp/default_keyboard string us" | debconf-set-selections

# Expose port for XRDP
EXPOSE 3389

# Start the XRDP service
CMD ["sh", "-c", "service xrdp start && tail -f /dev/null"]
# DEBUG=pw:browser google-chrome --no-sandbox
