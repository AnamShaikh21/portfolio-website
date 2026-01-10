# # 1. Base image (Python runtime)
# FROM python:3.11-slim

# # 2. Set working directory inside container
# WORKDIR /app

# # 3. Copy project files into container
# COPY . /app

# # 4. Install dependencies
# RUN pip install flask

# # 5. Expose Flask port
# EXPOSE 5000

# # 6. Command to run the app
# CMD ["python", "app.py"]

# 1. Use a stable, lightweight Python image
FROM python:3.11-slim

# 2. Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. Set working directory
WORKDIR /app

# 4. Copy only dependency files first (layer caching)
COPY requirements.txt /app/

# 5. Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy application code
COPY . /app

# 7. Expose port
EXPOSE 5000

# 8. Run application
CMD ["python", "app.py"]
