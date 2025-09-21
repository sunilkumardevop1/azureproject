Prerequisites:
| Tool      | Version | Notes                        |
| --------- | ------- | ---------------------------- |
| Terraform | ≥1.3    | IaC                          |
| Azure CLI | ≥2.40   | Auth & AKS creds             |
| kubectl   | Latest  | AKS interaction              |
| Helm      | ≥3      | Install Prometheus/Grafana   |
| Checkov   | Latest  | Security scan (or Terrascan) |


Azure Resources Created

Resource Group: Hosts all resources.

Virtual Network + Subnet: For AKS nodes and ACR.

Azure Container Registry (ACR): Stores application images.

Azure Kubernetes Service (AKS): Private cluster with RBAC enabled.

Steps

Clone the Repository

git clone https://github.com/<your-org>/walmart-aks-project.git
cd walmart-aks-project/infra


Create Remote State Backend (once)

az group create -n tfstate-rg -l eastus
az storage account create -g tfstate-rg -n <uniqueStorageName> -l eastus --sku Standard_LRS
az storage container create --name tfstate --account-name <uniqueStorageName>


Update backend.tf with these details.

Initialize & Validate

terraform init
terraform fmt -check
terraform validate


Plan

terraform plan -out=tfplan


Apply

terraform apply tfplan


This provisions the RG, VNet, ACR, and AKS cluster.

Get AKS Credentials

az aks get-credentials --resource-group <rg-name> --name <aks-name>


Deploy Monitoring (after cluster is ready)

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install monitoring prometheus-community/kube-prometheus-stack \
    -f ../k8s/prometheus-values.yaml --namespace monitoring --create-names

