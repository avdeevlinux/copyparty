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

# Install Python dependencies
USER appuser
RUN pip install --no-cache-dir --user .

# Expose default ports
EXPOSE 3923 3924

# Run copyparty
ENTRYPOINT ["python", "-m", "copyparty"]
