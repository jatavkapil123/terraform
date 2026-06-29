terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
  required_version = ">= 1.3.0"

  # recommended: remote state for prod
  # backend "azurerm" {
  #   resource_group_name  = "tfstate-rg"
  #   storage_account_name = "tfstateprod"
  #   container_name       = "tfstate"
  #   key                  = "prod.terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
}

module "aks" {
  source = "../../modules/aks"

  resource_group_name = local.config.resource_group_name
  location            = local.config.location
  cluster_name        = local.config.cluster_name
  node_count          = local.config.node_count
  vm_size             = local.config.vm_size
  load_balancer_sku   = local.config.load_balancer_sku
  tags                = local.config.tags
}

module "website" {
  source = "../../modules/kubernetes"

  kube_config    = module.aks.kube_config
  namespace      = local.config.namespace
  website_image  = local.config.website_image
  replica_count  = local.config.replica_count
  cpu_limit      = local.config.cpu_limit
  memory_limit   = local.config.memory_limit
  cpu_request    = local.config.cpu_request
  memory_request = local.config.memory_request
}
