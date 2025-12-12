# Use official Python slim image
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc python3-dev libffi-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY copyparty-sfx.py config.conf ./

# Create non-root user
RUN useradd -m -u 1000 appuser
RUN chown -R appuser:appuser /app
RUN mkdir -p /app/data/uploads
RUN chmod -R 777 /app
RUN chown -R appuser:appuser /app/data

# Switch to appuser
USER appuser

# Expose default ports
EXPOSE 3923

# Run copyparty with config
ENTRYPOINT ["python","copyparty-sfx.py","-c","config.conf","-v","/data/uploads:/app/data/uploads"]
