# Use an official Python runtime as a slim parent image
# 'slim' images are smaller and more secure than 'full' images.
FROM python:3.13-slim

# Set environment variables inside the container
# Prevents Python from writing pyc files and buffers stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /app

# Install system dependencies required for building Python packages
# This is a common step for slim images.
RUN apt-get update && apt-get install -y \
    gcc \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Copy the requirements file first to leverage Docker cache
# This means `pip install` only re-runs if requirements.txt changes.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Expose the port the app runs on
EXPOSE 8081

# Define environment variables for production (can be overridden at runtime)
ENV HOST="0.0.0.0" PORT="8080" DEBUG="False"

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
CMD curl -f http://localhost:8080/health || exit 1
# alternative, CMD [ "/bin/sh", "-c", "curl -f http://localhost:8080/health || exit 1" ] because it's a shell form not exec form, like the '||' which cannot be recognized in exec form as the final exec CMD

# Run Gunicorn. This is the production command.
# We use Gunicorn directly now, not the Flask dev server.
CMD ["gunicorn", "--bind", "0.0.0.0:8081", "flask_app:app"]