# Use Python 3.12 slim image as base
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies including matplotlib backend requirements
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libblas-dev \
    liblapack-dev \
    gfortran \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY app.py .
COPY index.html .
COPY entrypoint.sh .

# Copy environment file if it exists
COPY .env* ./

# Make entrypoint script executable
RUN chmod +x entrypoint.sh

# Create a non-root user for security
RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application
CMD ["./entrypoint.sh"]