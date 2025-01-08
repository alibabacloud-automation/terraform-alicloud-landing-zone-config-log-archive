output "project_id" {
  value       = one(alicloud_log_project.log_archive[*].id)
  description = "The id of the sls project. If you use an existed SLS project, this value is null."
}

output "project_create_time" {
  value       = one(alicloud_log_project.log_archive[*].create_time)
  description = "The create time of the sls project. If you use an existed SLS project, this value is null."
}

output "logstore_id" {
  value       = one(alicloud_log_store.log_archive[*].id)
  description = "The id of the sls logstore. If you use an existed SLS project, this value is null."
}

output "logstore_create_time" {
  value       = one(alicloud_log_store.log_archive[*].create_time)
  description = "The create time of the sls logstore. If you use an existed SLS project, this value is null."
}

output "logstore_shards" {
  value       = one(alicloud_log_store.log_archive[*].shards)
  description = "The shard attribute of the sls logstore. If you use an existed SLS project, this value is null."
}

output "delivery_channel_id" {
  value       = alicloud_config_aggregate_delivery.log_archive.delivery_channel_id
  description = "The ID of the delivery method. This parameter is required when you modify a delivery method."
}
