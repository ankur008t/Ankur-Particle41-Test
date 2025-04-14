FROM python:3.11-slim

WORKDIR /app

# Create a non-root user
RUN addgroup --system app && \
    adduser --system --group app

# Copy requirements and install dependencies
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/ .

# Change ownership to non-root user
RUN chown -R app:app /app

# Switch to non-root user
USER app

# Expose the port
EXPOSE 8000

# Start the application
CMD ["python", "main.py"]
