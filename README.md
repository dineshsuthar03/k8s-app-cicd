"# k8s-app-cicd" 
# Kubernetes Full-Stack Application (Flask + React + MySQL)

This project demonstrates the deployment of a full-stack application using Kubernetes. It consists of the following components:

- **Flask**: Backend API serving data.
- **MySQL**: Database container to store data.
- **React**: Frontend application that interacts with the Flask API.

## Prerequisites

Before getting started, ensure that you have the following tools installed:

1. **Kubernetes Cluster**: Set up a Kubernetes cluster (can be on AWS, GCP, or locally using Minikube or Docker Desktop).
2. **kubectl**: Kubernetes command-line tool to interact with the cluster.
3. **Docker**: To build the images for Flask and React applications.

## Project Directory Structure





### Backend (Flask) Application

- **app.py**: The main Flask API.
- **requirements.txt**: Python dependencies for Flask (e.g., `Flask`, `MySQL` client).
- **Dockerfile**: Instructions to build a Docker image for the Flask API.

### Frontend (React) Application

- **App.js**: The main React component that interacts with the Flask API.
- **index.js**: The entry point for the React application.
- **Dockerfile**: Instructions to build a Docker image for the React application.

### Kubernetes Configuration

The `k8s` directories contain Kubernetes manifests to deploy the backend (Flask), database (MySQL), and frontend (React) services.

---

## Step-by-Step Deployment

Follow these steps to deploy the application on a Kubernetes cluster.

### 1. **Build Docker Images**

#### Backend (Flask) Docker Image

1. Navigate to the `backend/` directory.
2. Build the Docker image:
   ```bash
   docker build -t flask-backend .












Frontend (React) Docker Image
Navigate to the frontend/ directory.
Build the Docker image:
bash

docker build -t react-frontend .
2. Push Docker Images to Docker Hub
To deploy these Docker images to Kubernetes, you need to push them to Docker Hub (or any container registry).

bash

# Login to Docker Hub
docker login

# Push the backend (Flask) image
docker tag flask-backend <your-docker-username>/flask-backend
docker push <your-docker-username>/flask-backend

# Push the frontend (React) image
docker tag react-frontend <your-docker-username>/react-frontend
docker push <your-docker-username>/react-frontend
Make sure to replace <your-docker-username> with your Docker Hub username.

3. Deploy on Kubernetes
Apply Kubernetes Manifests
Once the images are available in Docker Hub, you can apply the Kubernetes configurations. These configurations include deployments and services for the Flask backend, MySQL database, and React frontend.

On the master node, run the following commands:

bash

# Deploy Flask backend
kubectl apply -f k8s-app/backend/k8s/flask-deployment.yaml
kubectl apply -f k8s-app/backend/k8s/flask-service.yaml

# Deploy MySQL database
kubectl apply -f k8s-app/backend/k8s/mysql-deployment.yaml
kubectl apply -f k8s-app/backend/k8s/mysql-service.yaml

# Deploy React frontend
kubectl apply -f k8s-app/frontend/k8s/react-deployment.yaml
kubectl apply -f k8s-app/frontend/k8s/react-service.yaml
Verify Deployments and Services
After running the commands, verify that all pods and services are running correctly.

bash

kubectl get pods
kubectl get services
This will display the status of your pods and services. The Flask, MySQL, and React services should be up and running.

Accessing the Application
React Frontend: If you have exposed the React service using a NodePort or LoadBalancer, you can access it via the external IP and port.
Example: http://<node-ip>:<node-port>
Flask Backend: You can check the Flask service by accessing the backend API from the React app or through a kubectl port-forward command if needed.
Project Architecture
Flask API: The backend API serves data to the frontend. It connects to the MySQL database to fetch and store data.
MySQL: The MySQL database stores data used by the Flask API.
React Frontend: The React application interacts with the Flask API to display data to users.
Cleanup
Once you're done with the application, you can delete the deployments and services using the following commands:

bash

# Delete Flask backend
kubectl delete -f k8s-app/backend/k8s/flask-deployment.yaml
kubectl delete -f k8s-app/backend/k8s/flask-service.yaml

# Delete MySQL database
kubectl delete -f k8s-app/backend/k8s/mysql-deployment.yaml
kubectl delete -f k8s-app/backend/k8s/mysql-service.yaml

# Delete React frontend
kubectl delete -f k8s-app/frontend/k8s/react-deployment.yaml
kubectl delete -f k8s-app/frontend/k8s/react-service.yaml
Conclusion
This project demonstrates a simple full-stack application (Flask + MySQL + React) deployed using Kubernetes. You can extend this by adding more features, scaling the application, or integrating other tools and technologies.

License
This project is licensed under the MIT License - see the LICENSE file for details.

markdown


---

### Explanation:

1. **Project Structure**: The structure has been detailed, including backend, frontend, and Kubernetes YAML files.
2. **Build & Push Docker Images**: Steps to build Docker images for Flask and React applications and push them to Docker Hub.
3. **Kubernetes Deployment**: Instructions on applying Kubernetes manifests (`kubectl apply -f ...` commands) and verifying the services and pods.
4. **Accessing the Application**: Instructions to access the frontend via `NodePort` or `LoadBalancer`.
5. **Cleanup**: Cleanup commands for removing the Kubernetes deployments and services.

This `README.md` should provide a clear, step-by-step guide to setting up and deploying this application in Kubernetes.





