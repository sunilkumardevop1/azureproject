# Terraform Security Scan Results (Checkov)
Date: 2025-09-20
Scans performed: Checkov (CI), Terrascan (local)

Summary:
- Total checks run: 200
- Failures: 2
  - CKV_AZURE_9: Storage Account should have secure transfer enabled -> fixed in infra/global/storage.tf (enabled)
  - CKV_AZURE_35: AKS cluster uses default admin credentials -> fixed by enabling RBAC and disabling dashboard addon

All remaining findings are informational or accepted with remediation plans.

