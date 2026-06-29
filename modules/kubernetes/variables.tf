variable "kube_config" {
  description = "Kube config object from AKS module"
  type = object({
    host                   = string
    client_certificate     = string
    client_key             = string
    cluster_ca_certificate = string
  })
  sensitive = true
}

variable "namespace" {
  type    = string
  default = "website"
}

variable "website_image" {
  type    = string
  default = "nginx:latest"
}

variable "replica_count" {
  type    = number
  default = 1
}

variable "container_port" {
  type    = number
  default = 80
}

variable "cpu_limit" {
  type    = string
  default = "250m"
}

variable "memory_limit" {
  type    = string
  default = "128Mi"
}

variable "cpu_request" {
  type    = string
  default = "100m"
}

variable "memory_request" {
  type    = string
  default = "64Mi"
}
