output "resource_manager_delegated_administrator_id" {
  value       = alicloud_resource_manager_delegated_administrator.management.id
  description = "The resource ID of Delegated Administrator. The value formats as <account_id>:<service_principal>."
}

output "aggregator_id" {
  value       = alicloud_config_aggregator.log_archive.id
  description = "The resource ID in terraform of Aggregator."
}

output "delivery_to_sls" {
  value       = length(module.delivery_to_sls) > 0 ? module.delivery_to_sls[0] : null
  description = "The outputs of config delivery that deliver logs to sls."
}

output "delivery_to_oss" {
  value       = length(module.delivery_to_oss) > 0 ? module.delivery_to_oss[0] : null
  description = "The outputs of config delivery that deliver logs to oss."
}
