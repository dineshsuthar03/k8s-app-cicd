#!/bin/bash

# Base directory
BASE_DIR="k8s-app"

# Create directories for the backend
mkdir -p $BASE_DIR/backend/k8s
echo "# Flask application" > $BASE_DIR/backend/app.py
echo "# Python dependencies" > $BASE_DIR/backend/requirements.txt
echo "# Dockerfile for Flask" > $BASE_DIR/backend/Dockerfile
echo "# Flask Deployment YAML" > $BASE_DIR/backend/k8s/flask-deployment.yaml
echo "# Flask Service YAML" > $BASE_DIR/backend/k8s/flask-service.yaml
echo "# MySQL Deployment YAML" > $BASE_DIR/backend/k8s/mysql-deployment.yaml
echo "# MySQL Service YAML" > $BASE_DIR/backend/k8s/mysql-service.yaml

# Create directories for the frontend
mkdir -p $BASE_DIR/frontend/public
mkdir -p $BASE_DIR/frontend/src
mkdir -p $BASE_DIR/frontend/k8s
echo "// Main React component" > $BASE_DIR/frontend/src/App.js
echo "// React entry point" > $BASE_DIR/frontend/src/index.js
echo "# React dependencies" > $BASE_DIR/frontend/package.json
echo "# Dockerfile for React" > $BASE_DIR/frontend/Dockerfile
echo "# React Deployment YAML" > $BASE_DIR/frontend/k8s/react-deployment.yaml
echo "# React Service YAML" > $BASE_DIR/frontend/k8s/react-service.yaml

# Add a README.md file
echo "# Documentation" > $BASE_DIR/README.md

echo "Directory structure for k8s-app created successfully!"
