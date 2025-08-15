#!/bin/sh
set -e

echo "Starting application..."
echo "PORT: ${PORT:-8000}"
echo "Working directory: $(pwd)"
echo "Files in directory: $(ls -la)"

# Check if required files exist
if [ ! -f "app.py" ]; then
    echo "ERROR: app.py not found!"
    exit 1
fi

if [ ! -f "index.html" ]; then
    echo "ERROR: index.html not found!"
    exit 1
fi

echo "Starting uvicorn server..."
echo "Command: uvicorn app:app --host 0.0.0.0 --port ${PORT:-8000} --log-level info"
exec uvicorn app:app --host 0.0.0.0 --port ${PORT:-8000} --log-level info --access-log