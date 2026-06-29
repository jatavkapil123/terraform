# ─────────────────────────────────────────────
# DEV / STUDENT  —  change values here only
# ─────────────────────────────────────────────
locals {
  config = {
    # Azure
    resource_group_name = "student-aks-rg-dev"
    location            = "centralindia"  # change to your allowed region
    cluster_name        = "student-aks-dev"

    # Node pool — cheap for student account
    node_count        = 1
    vm_size           = "Standard_B2s_v2"
    load_balancer_sku = "standard"

    # Kubernetes
    namespace     = "website"
    website_image = "nginx:latest"   # swap with your image
    replica_count = 1

    # Resource limits
    cpu_limit      = "250m"
    memory_limit   = "128Mi"
    cpu_request    = "100m"
    memory_request = "64Mi"

    tags = {
      Environment = "dev"
      Project     = "my-website"
      ManagedBy   = "terraform"
    }
  }
}
