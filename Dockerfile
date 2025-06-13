FROM mysterysd/wzmlx:v3

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    python3-pip \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Install uv for faster pip operations
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:$PATH"

# Create virtual environment
RUN uv venv --system-site-packages

# Copy and install requirements
COPY requirements.txt .
RUN uv pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Make start script executable
RUN chmod +x start.sh

# Run the bot
CMD ["/bin/bash", "start.sh"]