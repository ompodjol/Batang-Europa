#!/bin/bash

# Batang Europa Basketball - Deployment Script
# This script helps deploy the application to different environments

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    print_error "Python 3 is not installed"
    exit 1
fi

print_status "Python 3 found: $(python3 --version)"

# Function to setup development environment
setup_dev() {
    print_status "Setting up development environment..."
    python3 -m venv venv
    source venv/bin/activate
    pip install --upgrade pip
    pip install -r requirements.txt
    print_status "Development environment ready!"
    print_status "Run: source venv/bin/activate && python app.py"
}

# Function to setup production environment
setup_prod() {
    print_status "Setting up production environment..."
    python3 -m venv venv_prod
    source venv_prod/bin/activate
    pip install --upgrade pip
    pip install -r requirements-prod.txt
    print_status "Production environment ready!"
    print_status "Run: source venv_prod/bin/activate && gunicorn --config gunicorn_config.py app:app"
}

# Function to run with Docker
setup_docker() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed"
        exit 1
    fi
    
    print_status "Building Docker image..."
    docker build -t batang-europa:latest .
    print_status "Docker image built successfully!"
    print_status "Run: docker run -p 1981:1981 batang-europa:latest"
}

# Function to run with Docker Compose
setup_docker_compose() {
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed"
        exit 1
    fi
    
    print_status "Starting with Docker Compose..."
    docker-compose up -d
    print_status "Service started! Access at http://localhost:1981"
}

# Main menu
if [ $# -eq 0 ]; then
    echo "Batang Europa Basketball - Deployment Script"
    echo ""
    echo "Usage: $0 <option>"
    echo ""
    echo "Options:"
    echo "  dev              Setup development environment"
    echo "  prod             Setup production environment"
    echo "  docker           Setup Docker environment"
    echo "  docker-compose   Start with Docker Compose"
    echo ""
    exit 1
fi

case "$1" in
    dev)
        setup_dev
        ;;
    prod)
        setup_prod
        ;;
    docker)
        setup_docker
        ;;
    docker-compose)
        setup_docker_compose
        ;;
    *)
        print_error "Unknown option: $1"
        exit 1
        ;;
esac
