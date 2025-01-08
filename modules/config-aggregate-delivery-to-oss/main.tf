data "alicloud_account" "log_archive" {
}

# Create a oss bucket
resource "alicloud_oss_bucket" "log_archive" {
  count             = var.use_existed_bucket ? 0 : 1
  bucket            = var.bucket_name
  storage_class     = var.bucket_storage_class
  redundancy_type   = var.bucket_redundancy_type
  tags              = var.bucket_tags
  force_destroy     = var.bucket_force_destroy
  resource_group_id = var.bucket_resource_group_id

  lifecycle {
    ignore_changes = [
      cors_rule,
      website,
      logging,
      referer_config,
      lifecycle_rule,
      server_side_encryption_rule,
      versioning,
      transfer_acceleration,
      access_monitor
    ]
  }
}

locals {
  bucket_region = length(alicloud_oss_bucket.log_archive) > 0 ? replace(alicloud_oss_bucket.log_archive[0].location, "oss-", "") : var.existed_bucket_region
  bucket_arn    = format("acs:oss:%s:%s:%s", local.bucket_region, data.alicloud_account.log_archive.id, var.bucket_name)
}

# Create a config delivery and deliver logs to the bucket
resource "alicloud_config_aggregate_delivery" "log_archive" {
  aggregator_id                          = var.aggregator_id
  delivery_channel_name                  = var.delivery_channel_name
  description                            = var.delivery_channel_description
  delivery_channel_type                  = "OSS"
  delivery_channel_target_arn            = local.bucket_arn
  delivery_channel_condition             = var.delivery_channel_condition
  status                                 = 1
  configuration_item_change_notification = var.configuration_item_change_notification
  configuration_snapshot                 = var.configuration_snapshot
}
