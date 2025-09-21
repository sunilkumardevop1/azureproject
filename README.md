# azureproject
1️⃣ Overview

Infrastructure-as-Code solution to provision a production-like Azure Kubernetes Service (AKS) environment, deploy a sample microservice, and configure monitoring (Prometheus & Grafana) with automated CI/CD and Terraform security scanning.

2️⃣ Assumptions

You have an Azure subscription with contributor rights.

Terraform ≥1.3, Azure CLI ≥2.40, kubectl, and Helm ≥3 are installed.

GitHub Actions is used for CI/CD (OIDC authentication to Azure).

Azure Container Registry (ACR) stores Docker images.

3️⃣ Folder Structure

Key directories:

infra/ – Terraform code for VNet, ACR, AKS.

app/ – Sample Flask microservice (Docker + K8s manifests).

k8s/ – Helm values and Grafana dashboards.

.github/workflows/ – CI/CD pipelines.

4️⃣ Quick Setup

1. Clone repo
git clone https://github.com//walmart-aks-project.git cd walmart-aks-project/infra

2. Initialize Terraform backend
terraform init

3. Deploy infrastructure
terraform plan -out=tfplan terraform apply tfplan

4. Get AKS credentials
az aks get-credentials --resource-group --name

5. Deploy app & monitoring
kubectl apply -f ../app/service-a/k8s helm install monitoring prometheus-community/kube-prometheus-stack
-f ../k8s/prometheus-values.yaml --namespace monitoring --create-namespace

5️⃣ CI/CD Workflow

terraform.yml – Scans (Checkov), plans, and applies Terraform changes.

build-and-push.yml – Builds and pushes Docker image to ACR.

deploy-k8s.yml – Updates AKS deployment with the new image.

6️⃣ Access Instructions

Sample App: kubectl port-forward svc/service-a 8080:80 → http://localhost:8080

Grafana: kubectl port-forward svc/monitoring-grafana -n monitoring 3000:80 → http://localhost:3000 (use admin password from Kubernetes secret).

7️⃣ Monitoring & Reporting

Prometheus scrapes cluster/app metrics; Grafana dashboards show CPU, memory, latency, and error rates. A scheduled GitHub Action exports daily dashboard images to Azure Storage.

8️⃣ Security Controls

Private AKS cluster with RBAC enabled.

Managed identities for AKS→ACR access.

Remote Terraform state in Azure Storage with secure transfer.

Automated Checkov scanning blocks non-compliant code.

9️⃣ Design Decisions

GitHub Actions + OIDC for secret-less Azure authentication.

Helm (kube-prometheus-stack) for simplified monitoring installation.

Simple Flask app for easy demonstration of microservice deployment.

🔟 Next Steps

Customize Grafana dashboards under k8s/grafana-provisioning/.
