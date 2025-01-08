output "bucket_id" {
  value       = length(alicloud_oss_bucket.log_archive) > 0 ? alicloud_oss_bucket.log_archive[0].id : var.bucket_name
  description = " The id of the bucket. The value is the same as bucket name."
}

output "bucket_creation_date" {
  value       = one(alicloud_oss_bucket.log_archive[*].creation_date)
  description = "The creation date of the bucket. If you use an existed OSS bucket, this value is null."
}

output "bucket_extranet_endpoint" {
  value       = one(alicloud_oss_bucket.log_archive[*].extranet_endpoint)
  description = "The extranet access endpoint of the bucket. If you use an existed OSS bucket, this value is null."
}

output "bucket_intranet_endpoint" {
  value       = one(alicloud_oss_bucket.log_archive[*].intranet_endpoint)
  description = "The intranet access endpoint of the bucket. If you use an existed OSS bucket, this value is null."
}

output "bucket_location" {
  value       = one(alicloud_oss_bucket.log_archive[*].location)
  description = "The location of the bucket. If you use an existed OSS bucket, this value is null."
}

output "delivery_channel_id" {
  value       = alicloud_config_aggregate_delivery.log_archive.delivery_channel_id
  description = "The ID of the delivery method. This parameter is required when you modify a delivery method."
}
