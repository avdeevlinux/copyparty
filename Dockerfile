# Use official Python slim image
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc python3-dev libffi-dev && \
    rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m appuser
WORKDIR /app
COPY . .
RUN chown -R appuser:appuser /app
# RUN mkdir /app/data && mkdir /app/data/music && mkdir /app/data/inc && mkdir /app/data/inc/sharex
# RUN chmod 775 -R /app/data && chmod 775 -R /app/data/music && chmod 775 -R /app/data/inc && chmod 775 -R /app/data/inc/sharex

# Install Python dependencies
USER appuser
RUN pip install --no-cache-dir --user .

# Expose default ports
EXPOSE 3923

# Copy config file
COPY config.conf .

# Run copyparty with config
ENTRYPOINT ["python","setup.py","-m","copyparty","-c","config.conf"]
