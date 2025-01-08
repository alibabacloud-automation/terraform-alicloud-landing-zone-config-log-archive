variable "aggregator_id" {
  type        = string
  description = "Config aggregator ID."
}

variable "delivery_channel_name" {
  type        = string
  description = "The name of the config delivery channel."
}

variable "delivery_channel_description" {
  type        = string
  description = "The description of the config delivery channel."
  default     = null
}

variable "delivery_channel_condition" {
  type        = string
  description = "The rule that is attached to the delivery channel."
  default     = null
}

variable "configuration_item_change_notification" {
  type        = bool
  description = "Indicates whether the specified destination receives resource change logs. If the value of this parameter is true, Cloud Config delivers the resource change logs to OSS when the configurations of the resources change. "
  default     = true
}

variable "configuration_snapshot" {
  type        = bool
  description = "Indicates whether the specified destination receives scheduled resource snapshots. Cloud Config delivers scheduled resource snapshots at 04:00Z and 16:00Z to OSS every day. The time is displayed in UTC. "
  default     = true
}

variable "use_existed_bucket" {
  type        = bool
  description = "Whether to use an existed OSS bucket."
  default     = false
}

variable "existed_bucket_region" {
  type        = string
  description = "When use an existed OSS bucket, you should specify the region of the bucket."
  default     = null
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket. When use an existed OSS bucket, you should specify the existed bucket name."
}

variable "bucket_storage_class" {
  type        = string
  description = "The storage class to apply. Can be \"Standard\", \"IA\", \"Archive\", \"ColdArchive\" and \"DeepColdArchive\"."
  default     = "Standard"
}

variable "bucket_redundancy_type" {
  type        = string
  description = "The redundancy type to enable. Can be \"LRS\", and \"ZRS\"."
  default     = "ZRS"
}

variable "bucket_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the oss bucket."
  default     = {}
}

variable "bucket_force_destroy" {
  type        = bool
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = false
}

variable "bucket_resource_group_id" {
  type        = string
  description = "The ID of the resource group to which the bucket belongs."
  default     = null
}
