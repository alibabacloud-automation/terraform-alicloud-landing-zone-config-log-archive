output "resource_manager_delegated_administrator_id" {
  value       = module.config_log_archive.resource_manager_delegated_administrator_id
  description = "The resource ID of Delegated Administrator. The value formats as <account_id>:<service_principal>."
}

output "aggregator_id" {
  value       = module.config_log_archive.aggregator_id
  description = "The resource ID in terraform of Aggregator."
}

output "delivery_to_sls" {
  value       = module.config_log_archive.delivery_to_sls
  description = "The outputs of config delivery that deliver logs to sls."
}

output "delivery_to_oss" {
  value       = module.config_log_archive.delivery_to_oss
  description = "The outputs of config delivery that deliver logs to oss."
}
