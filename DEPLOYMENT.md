# Batang Europa Basketball - Comprehensive Deployment Guide

## 🚀 Deployment Overview

This guide covers multiple deployment options for the Batang Europa Basketball website.

## Table of Contents

1. [Local Development](#local-development)
2. [Docker Deployment](#docker-deployment)
3. [Cloud Deployment](#cloud-deployment)
4. [Production Checklist](#production-checklist)
5. [Monitoring & Maintenance](#monitoring--maintenance)

---

## Local Development

### Option 1: Using Python Virtual Environment

```bash
# Clone the repository
git clone https://github.com/ompodjol/Batang-Europa.git
cd Batang-Europa

# Create virtual environment
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run the application
python app.py
```

Access: `http://localhost:1981`

### Option 2: Using Deploy Script

```bash
# Make the script executable
chmod +x deploy.sh

# Setup development environment
./deploy.sh dev

# Activate and run
source venv/bin/activate
python app.py
```

---

## Docker Deployment

### Building and Running Docker Image

```bash
# Build the Docker image
docker build -t batang-europa:latest .

# Run the container
docker run -p 1981:1981 batang-europa:latest

# Run in background (detached mode)
docker run -d -p 1981:1981 --name batang-app batang-europa:latest

# View logs
docker logs -f batang-app

# Stop the container
docker stop batang-app
docker rm batang-app
```

### Using Docker Compose

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Rebuild after code changes
docker-compose up -d --build
```

Access: `http://localhost:1981`

---

## Cloud Deployment

### Heroku Deployment

#### Prerequisites
- Heroku CLI installed
- Git repository initialized

#### Steps

```bash
# Login to Heroku
heroku login

# Create app
heroku create batang-europa

# Add Procfile content to deploy with Gunicorn
echo "web: gunicorn --config gunicorn_config.py app:app" > Procfile

# Set environment variables
heroku config:set FLASK_ENV=production
heroku config:set SECRET_KEY=your-secret-key-here

# Deploy
git push heroku main

# View logs
heroku logs --tail

# Open app
heroku open
```

**Custom Domain:**
```bash
heroku domains:add www.batangeuropa.com
```

### AWS EC2 Deployment

#### Prerequisites
- AWS account
- EC2 instance (Ubuntu 20.04 or later)
- Elastic IP address

#### Steps

```bash
# SSH into instance
ssh -i your-key.pem ubuntu@your-instance-ip

# Update system
sudo apt update && sudo apt upgrade -y

# Install Python and pip
sudo apt install python3 python3-pip python3-venv -y

# Install Nginx
sudo apt install nginx -y

# Clone repository
git clone https://github.com/ompodjol/Batang-Europa.git ~/app
cd ~/app

# Setup virtual environment
python3 -m venv venv
source venv/bin/activate
pip install -r requirements-prod.txt

# Create systemd service file
sudo tee /etc/systemd/system/batang-europa.service > /dev/null << 'EOF'
[Unit]
Description=Batang Europa Basketball
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/app
ExecStart=/home/ubuntu/app/venv/bin/gunicorn --config gunicorn_config.py app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Enable and start service
sudo systemctl daemon-reload
sudo systemctl enable batang-europa
sudo systemctl start batang-europa
sudo systemctl status batang-europa

# Configure Nginx
sudo tee /etc/nginx/sites-available/batang-europa > /dev/null << 'EOF'
server {
    listen 80;
    server_name your-domain.com www.your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:1981;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

# Enable site
sudo ln -s /etc/nginx/sites-available/batang-europa /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

### PythonAnywhere Deployment

1. Create free account at [pythonanywhere.com](https://www.pythonanywhere.com)
2. Upload files via web interface or git
3. Create web app using Flask framework
4. Configure WSGI file
5. Set up custom domain in account settings

### Google Cloud Run Deployment

```bash
# Authenticate
gcloud auth login

# Set project
gcloud config set project PROJECT_ID

# Build and push to Container Registry
gcloud builds submit --tag gcr.io/PROJECT_ID/batang-europa

# Deploy to Cloud Run
gcloud run deploy batang-europa \
  --image gcr.io/PROJECT_ID/batang-europa \
  --platform managed \
  --region us-central1 \
  --port 1981

# View deployment
gcloud run services describe batang-europa --platform managed --region us-central1
```

### Azure App Service Deployment

```bash
# Login
az login

# Create resource group
az group create --name batang-europa-rg --location eastus

# Create App Service plan
az appservice plan create --name batang-europa-plan --resource-group batang-europa-rg --sku B1

# Create web app
az webapp create --resource-group batang-europa-rg --plan batang-europa-plan --name batang-europa

# Configure deployment
az webapp deployment source config-zip --resource-group batang-europa-rg --name batang-europa --src app.zip
```

---

## Production Checklist

Before deploying to production:

- [ ] Set `FLASK_ENV=production`
- [ ] Generate a strong `SECRET_KEY`
- [ ] Disable debug mode (`DEBUG=False`)
- [ ] Use a production WSGI server (Gunicorn)
- [ ] Set up proper logging
- [ ] Configure error handling
- [ ] Set up HTTPS/SSL certificate
- [ ] Configure database backups
- [ ] Set up monitoring and alerts
- [ ] Configure rate limiting
- [ ] Set up email notifications
- [ ] Test all features in production
- [ ] Set up automated deployments (CI/CD)

### Security Checklist

- [ ] Change default SECRET_KEY
- [ ] Use environment variables for sensitive data
- [ ] Enable HTTPS only
- [ ] Add CORS headers if needed
- [ ] Implement rate limiting
- [ ] Validate all user inputs
- [ ] Use parameterized queries
- [ ] Keep dependencies updated
- [ ] Set up Web Application Firewall (WAF)
- [ ] Enable CSRF protection

---

## Monitoring & Maintenance

### Logging

```python
# Add logging to app.py
import logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)
```

### Health Check Endpoint

```python
@app.route('/health')
def health():
    return {'status': 'healthy'}, 200
```

### Backup Strategy

- Daily backups of database
- Version control commits
- Regular testing of backups

### Updates & Patches

```bash
# Check for dependency updates
pip list --outdated

# Update dependencies
pip install --upgrade -r requirements-prod.txt

# Test before deploying to production
python -m pytest tests/
```

### Performance Optimization

- Enable caching headers
- Compress static files
- Use CDN for assets
- Database query optimization
- Load testing with Apache Bench or JMeter

```bash
# Example: Load testing
ab -n 1000 -c 10 http://localhost:1981/
```

---

## Troubleshooting

### Application won't start
- Check logs: `docker logs container-id` or `heroku logs --tail`
- Verify PORT environment variable
- Ensure dependencies are installed

### 502 Bad Gateway
- Check if Gunicorn is running
- Verify proxy configuration
- Check firewall rules

### Slow performance
- Profile with `py-spy`
- Check database queries
- Monitor server resources
- Enable caching

### Port already in use
```bash
# Find process using port
lsof -i :1981

# Kill process
kill -9 PID
```

---

## Support & Resources

- [Flask Documentation](https://flask.palletsprojects.com/)
- [Gunicorn Documentation](https://gunicorn.org/)
- [Docker Documentation](https://docs.docker.com/)
- [Heroku Documentation](https://devcenter.heroku.com/)

---

**Last Updated**: April 23, 2026
