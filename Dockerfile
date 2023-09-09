FROM python:3.9-slim

WORKDIR /app

# Install required packages
RUN apt-get update && apt-get install -y cron

# Copy requirements.txt and install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy your script and other necessary files (like `.env` if you have any)
COPY main.py .env* /app/

# Set up cron
COPY crontab /etc/cron.d/your-cron-job
RUN chmod 0644 /etc/cron.d/your-cron-job && touch /var/log/cron.log


CMD ["cron", "-f"]
