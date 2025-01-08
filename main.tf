# Activate config service
resource "alicloud_config_configuration_recorder" "log_archive" {
  provider = alicloud.log_archive_account
}

data "alicloud_account" "log_archive" {
  provider = alicloud.log_archive_account
}

# Delegate config administrator to log archive account
resource "alicloud_resource_manager_delegated_administrator" "management" {
  provider = alicloud.management_account

  account_id        = data.alicloud_account.log_archive.id
  service_principal = "config.aliyuncs.com"

  depends_on = [
    alicloud_config_configuration_recorder.log_archive
  ]
}

# Create aggregator
resource "alicloud_config_aggregator" "log_archive" {
  provider = alicloud.log_archive_account

  aggregator_type = "RD"
  aggregator_name = var.aggregator_name
  description     = var.aggregator_description

  timeouts {
    create = "3m"
  }

  depends_on = [
    alicloud_resource_manager_delegated_administrator.management
  ]
}

module "delivery_to_sls" {
  source = "./modules/config-aggregate-delivery-to-sls"
  providers = {
    alicloud = alicloud.log_archive_account
  }
  count                                  = var.delivery_to_sls.enabled ? 1 : 0
  aggregator_id                          = alicloud_config_aggregator.log_archive.id
  delivery_channel_name                  = var.delivery_to_sls.delivery_channel_name
  delivery_channel_description           = var.delivery_to_sls.delivery_channel_description
  delivery_channel_condition             = var.delivery_to_sls.delivery_channel_condition
  configuration_item_change_notification = var.delivery_to_sls.configuration_item_change_notification
  configuration_snapshot                 = var.delivery_to_sls.configuration_snapshot
  non_compliant_notification             = var.delivery_to_sls.non_compliant_notification
  use_existed_project                    = var.delivery_to_sls.use_existed_project
  existed_project_region                 = var.delivery_to_sls.existed_project_region
  project_name                           = var.delivery_to_sls.project_name
  project_description                    = var.delivery_to_sls.project_description
  project_tags                           = var.delivery_to_sls.project_tags
  project_resource_group_id              = var.delivery_to_sls.project_resource_group_id
  logstore_name                          = var.delivery_to_sls.logstore_name
  logstore_append_meta                   = var.delivery_to_sls.logstore_append_meta
  logstore_auto_split                    = var.delivery_to_sls.logstore_auto_split
  logstore_max_split_shard_count         = var.delivery_to_sls.logstore_max_split_shard_count
  logstore_enable_web_tracking           = var.delivery_to_sls.logstore_enable_web_tracking
  logstore_hot_ttl                       = var.delivery_to_sls.logstore_hot_ttl
  logstore_infrequent_access_ttl         = var.delivery_to_sls.logstore_infrequent_access_ttl
  logstore_retention_period              = var.delivery_to_sls.logstore_retention_period
  logstore_mode                          = var.delivery_to_sls.logstore_mode
  logstore_shard_count                   = var.delivery_to_sls.logstore_shard_count
}

module "delivery_to_oss" {
  source = "./modules/config-aggregate-delivery-to-oss"
  providers = {
    alicloud = alicloud.log_archive_account
  }
  count                                  = var.delivery_to_oss.enabled ? 1 : 0
  aggregator_id                          = alicloud_config_aggregator.log_archive.id
  delivery_channel_name                  = var.delivery_to_oss.delivery_channel_name
  delivery_channel_description           = var.delivery_to_oss.delivery_channel_description
  delivery_channel_condition             = var.delivery_to_oss.delivery_channel_condition
  configuration_item_change_notification = var.delivery_to_oss.configuration_item_change_notification
  configuration_snapshot                 = var.delivery_to_oss.configuration_snapshot
  use_existed_bucket                     = var.delivery_to_oss.use_existed_bucket
  existed_bucket_region                  = var.delivery_to_oss.existed_bucket_region
  bucket_name                            = var.delivery_to_oss.bucket_name
  bucket_storage_class                   = var.delivery_to_oss.bucket_storage_class
  bucket_redundancy_type                 = var.delivery_to_oss.bucket_redundancy_type
  bucket_tags                            = var.delivery_to_oss.bucket_tags
  bucket_force_destroy                   = var.delivery_to_oss.bucket_force_destroy
  bucket_resource_group_id               = var.delivery_to_oss.bucket_resource_group_id
}
