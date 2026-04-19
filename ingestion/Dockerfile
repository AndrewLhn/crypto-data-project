FROM python:3.11-slim

WORKDIR /app


RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*


COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


RUN mkdir -p /app/src


COPY src/ /app/src/


ENV PYTHONPATH=/app/src


CMD ["python", "/app/src/scheduler.py"]
