# 1. Use stable Python image
FROM python:3.11-slim

# 2. Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. Create a non-root user
RUN addgroup --system appgroup && adduser --system --group appuser

# 4. Set working directory
WORKDIR /app

# 5. Copy dependency file first (layer caching)
COPY requirements.txt .

# 6. Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 7. Copy application code
COPY . .

# 8. Change ownership of app files
RUN chown -R appuser:appgroup /app

# 9. Switch to non-root user
USER appuser

# 10. Expose port
EXPOSE 5000

# 11. Run the application
CMD ["python", "app.py"]
