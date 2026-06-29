provider "kubernetes" {
  host                   = var.kube_config.host
  client_certificate     = base64decode(var.kube_config.client_certificate)
  client_key             = base64decode(var.kube_config.client_key)
  cluster_ca_certificate = base64decode(var.kube_config.cluster_ca_certificate)
}

resource "kubernetes_namespace" "website" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "website" {
  metadata {
    name      = "website"
    namespace = kubernetes_namespace.website.metadata[0].name
  }

  spec {
    replicas = var.replica_count

    selector {
      match_labels = { app = "website" }
    }

    template {
      metadata {
        labels = { app = "website" }
      }

      spec {
        container {
          name  = "website"
          image = var.website_image

          port {
            container_port = var.container_port
          }

          resources {
            limits = {
              cpu    = var.cpu_limit
              memory = var.memory_limit
            }
            requests = {
              cpu    = var.cpu_request
              memory = var.memory_request
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "website" {
  metadata {
    name      = "website"
    namespace = kubernetes_namespace.website.metadata[0].name
  }

  spec {
    selector = { app = "website" }

    port {
      port        = 80
      target_port = var.container_port
    }

    type = "LoadBalancer"
  }
}
