data "alicloud_account" "log_archive" {
}

# Create sls project
resource "alicloud_log_project" "log_archive" {
  count             = var.use_existed_project ? 0 : 1
  project_name      = var.project_name
  description       = var.project_description
  tags              = var.project_tags
  resource_group_id = var.project_resource_group_id
}

# Create sls logstore
resource "alicloud_log_store" "log_archive" {
  count                 = length(alicloud_log_project.log_archive) > 0 ? 1 : 0
  project_name          = var.project_name
  logstore_name         = var.logstore_name
  append_meta           = var.logstore_append_meta
  auto_split            = var.logstore_auto_split
  max_split_shard_count = var.logstore_max_split_shard_count
  enable_web_tracking   = var.logstore_enable_web_tracking
  hot_ttl               = var.logstore_hot_ttl
  infrequent_access_ttl = var.logstore_infrequent_access_ttl
  retention_period      = var.logstore_retention_period
  mode                  = var.logstore_mode
  shard_count           = var.logstore_shard_count

  lifecycle {
    ignore_changes = [
      encrypt_conf
    ]
  }
}

data "alicloud_log_projects" "log_archive" {
  count = length(alicloud_log_project.log_archive) > 0 ? 1 : 0
  ids   = [var.project_name]
}

locals {
  project_region = var.use_existed_project ? var.existed_project_region : try(data.alicloud_log_projects.log_archive[0].projects[0].region, "")
  project_arn    = format("acs:log:%s:%s:project/%s/logstore/%s", local.project_region, data.alicloud_account.log_archive.id, var.project_name, var.logstore_name)
}

# Create a config delivery and deliver logs to sls project
resource "alicloud_config_aggregate_delivery" "log_archive" {
  aggregator_id                          = var.aggregator_id
  delivery_channel_name                  = var.delivery_channel_name
  description                            = var.delivery_channel_description
  delivery_channel_type                  = "SLS"
  delivery_channel_target_arn            = local.project_arn
  delivery_channel_condition             = var.delivery_channel_condition
  status                                 = 1
  configuration_item_change_notification = var.configuration_item_change_notification
  configuration_snapshot                 = var.configuration_snapshot
  non_compliant_notification             = var.non_compliant_notification

  depends_on = [
    alicloud_log_store.log_archive
  ]
}
