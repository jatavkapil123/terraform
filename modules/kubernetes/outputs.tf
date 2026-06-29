output "website_ip" {
  description = "Public IP of the website (may take a minute)"
  value       = kubernetes_service.website.status[0].load_balancer[0].ingress[0].ip
}
