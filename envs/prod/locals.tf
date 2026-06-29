# ─────────────────────────────────────────────
# PROD  —  change values here only
# ─────────────────────────────────────────────
locals {
  config = {
    # Azure
    resource_group_name = "my-website-rg-prod"
    location            = "eastus"
    cluster_name        = "my-website-aks-prod"

    # Node pool — production grade
    node_count        = 2
    vm_size           = "Standard_D2s_v3"
    load_balancer_sku = "standard"

    # Kubernetes
    namespace     = "website"
    website_image = "nginx:latest"   # swap with your prod image
    replica_count = 2

    # Resource limits
    cpu_limit      = "500m"
    memory_limit   = "256Mi"
    cpu_request    = "200m"
    memory_request = "128Mi"

    tags = {
      Environment = "prod"
      Project     = "my-website"
      ManagedBy   = "terraform"
    }
  }
}
