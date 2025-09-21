CI/CD Pipeline Workflow

terraform.yml – PR & push to infra/: Terraform fmt/validate/plan, Checkov scan, apply on merge.

build-and-push.yml – Push to app/: Build Docker image and push to Azure Container Registry.

deploy-k8s.yml – Post image build: Get AKS creds, update Deployment, roll out update.
