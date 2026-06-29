output "website_ip" {
  value = module.website.website_ip
}

output "cluster_name" {
  value = module.aks.cluster_name
}

output "resource_group" {
  value = module.aks.resource_group_name
}
