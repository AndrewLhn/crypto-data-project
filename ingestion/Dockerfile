FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Create src directory
RUN mkdir -p /app/src

# Copy source code
COPY src/ /app/src/

# Set Python path
ENV PYTHONPATH=/app/src

# Run scheduler
CMD ["python", "/app/src/scheduler.py"]
