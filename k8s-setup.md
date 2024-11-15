Kubernetes Installation on AWS EC2 (Multi-Node Setup)
This guide provides instructions to install and configure a multi-node Kubernetes cluster on AWS EC2 instances running Ubuntu. The setup includes one master node and multiple worker nodes.

Prerequisites
AWS EC2 instances running Ubuntu (ensure that you have access to your AWS account and EC2 instances).
Ubuntu 20.04+ installed on EC2 instances.
Root or sudo access to all EC2 instances.
kubectl installed on your local machine for managing Kubernetes.
AWS CLI installed (optional, if you want to manage resources using AWS CLI).
Security groups configured to allow traffic between nodes and from your local machine (for SSH and Kubernetes port communication).
Step-by-Step Guide
1. Prepare EC2 Instances
Launch EC2 Instances:
Master Node: Launch one EC2 instance (Ubuntu) that will serve as the master node.
Worker Nodes: Launch additional EC2 instances (Ubuntu) that will act as worker nodes.
Make sure that the EC2 instances have:

At least 2 GB of RAM.
A security group that allows the following ports:
SSH: Port 22
Kubernetes API server: Port 6443
Kubernetes nodes (internal): Ports 10250, 10255, 2379-2380, 30000-32767
Update and Install Dependencies:
SSH into each EC2 instance and run the following commands:

bash

# Update packages and install required dependencies
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Disable swap (required for Kubernetes)
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab
2. Install Docker
Kubernetes uses Docker to manage containers. Install Docker on each node:

bash

# Install Docker
sudo apt-get install -y docker.io

# Start Docker and enable it to start on boot
sudo systemctl start docker
sudo systemctl enable docker

# Verify Docker installation
docker --version
3. Install Kubernetes Components
Add Kubernetes Repository:
Run these commands on all nodes (master and workers) to install Kubernetes:

bash

# Add the Kubernetes APT repository
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-add-repository "deb https://apt.kubernetes.io/ kubernetes-xenial main"

# Update the apt package list
sudo apt-get update
Install kubeadm, kubelet, and kubectl:
bash

# Install Kubernetes components
sudo apt-get install -y kubeadm kubelet kubectl

# Hold the Kubernetes packages to prevent them from being upgraded
sudo apt-mark hold kubeadm kubelet kubectl
4. Initialize Kubernetes Master Node
SSH into the Master Node and run the following command to initialize the Kubernetes master:

bash

sudo kubeadm init --pod-network-cidr=10.244.0.0/16
--pod-network-cidr=10.244.0.0/16 specifies the CIDR block for pod networking. This can vary depending on your chosen networking solution.
Once the command completes, you will see a message with a kubeadm join command. This command will be used to add worker nodes to the cluster. Copy this command.

You’ll also see a message with instructions to set up kubectl access to the master node. Run the following commands:

bash

# Set up kubeconfig for kubectl access
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Verify the master node
kubectl get nodes
5. Install Network Plugin (Weave or Flannel)
Kubernetes requires a network plugin for communication between pods. You can use Weave or Flannel. Here’s how to install Flannel:

bash

# Run Flannel network setup
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
Verify that the Flannel pods are running:

bash

kubectl get pods -n kube-system
6. Join Worker Nodes to the Cluster
SSH into each Worker Node and run the kubeadm join command you copied earlier from the master node. The command will look something like:

bash

sudo kubeadm join <master-node-ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
This command will join the worker node to the Kubernetes cluster. After the worker nodes are joined, run the following on the Master Node to verify:

bash

kubectl get nodes
This should show all the nodes in the cluster (Master + Workers).

7. Install kubectl on Your Local Machine (Optional)
To manage the Kubernetes cluster from your local machine, install kubectl on your local machine and configure it to point to the master node.

Follow the instructions here to install kubectl:
https://kubernetes.io/docs/tasks/tools/install-kubectl/

Once installed, run the following command to configure kubectl:

bash

scp ubuntu@<master-node-ip>:/etc/kubernetes/admin.conf ~/.kube/config
This will copy the Kubernetes config file to your local machine.

8. Verify Cluster and Node Status
Once the nodes are up and running, verify the status of the cluster:

bash

# On the Master node or your local machine (with kubectl configured)
kubectl get nodes
You should see output like:

css

NAME             STATUS    ROLES    AGE   VERSION
master-node      Ready     master   10m   v1.26.3
worker-node-1    Ready     <none>   5m    v1.26.3
worker-node-2    Ready     <none>   5m    v1.26.3
9. Deploy a Sample Application (Optional)
Deploy a sample application to verify that your Kubernetes setup is working correctly.

bash

# Create a sample nginx deployment
kubectl create deployment nginx --image=nginx

# Expose the deployment via a service
kubectl expose deployment nginx --port=80 --type=NodePort

# Get the external IP and port of the nginx service
kubectl get svc
You should now be able to access the Nginx service on the node’s external IP.

Conclusion
You’ve successfully installed and configured a multi-node Kubernetes cluster on AWS EC2 instances running Ubuntu. You can now deploy and manage containerized applications using Kubernetes.

Troubleshooting
Ensure all nodes are communicating over the required ports (6443 for API, 10250 for kubelet, etc.).
Check the logs of kubelet and kubeadm for errors:
bash

sudo journalctl -u kubelet
Cleanup
To clean up the cluster, remove the Kubernetes components and Docker:

bash

# On each node (master and worker)
sudo kubeadm reset
sudo apt-get purge -y kubeadm kubelet kubectl
sudo apt-get autoremove -y
sudo apt-get clean
sudo rm -rf $HOME/.kube
This documentation provides an overview of setting up a multi-node Kubernetes cluster on AWS EC2 with Ubuntu. By following these steps, you’ll have a working Kubernetes cluster for deploying containerized applications.