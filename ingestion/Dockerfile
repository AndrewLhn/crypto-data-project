FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (для кэширования)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Create src directory
RUN mkdir -p /app/src

# Copy source code
COPY src/ /app/src/

# Keep container running
CMD ["python", "-c", "import time; print('Scheduler container ready'); while True: time.sleep(3600)"]
