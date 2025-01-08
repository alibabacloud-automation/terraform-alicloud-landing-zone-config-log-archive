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

variable "non_compliant_notification" {
  type        = bool
  description = "Indicates whether the specified destination receives resource non-compliance events. If the value of this parameter is true, Cloud Config delivers resource non-compliance events to Log Service when resources are evaluated as non-compliant. "
  default     = true
}

variable "use_existed_project" {
  type        = bool
  description = "Whether to use an existed SLS project."
  default     = false
}

variable "existed_project_region" {
  type        = string
  description = "When use an existed SLS project, you should specify the region of the project."
  default     = null
}

variable "project_name" {
  type        = string
  description = "The name of the SLS project. When use an existed SLS project, you should specify the existed project name."
}

variable "project_description" {
  type        = string
  description = "The description of the SLS project."
  default     = null
}

variable "project_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the sls project."
  default     = {}
}

variable "project_resource_group_id" {
  type        = string
  description = "The ID of the resource group to which the project belongs."
  default     = null
}

variable "logstore_name" {
  type        = string
  description = "The name of the SLS logstore. When use an existed SLS project, you should specify an existed logstore name."
}

variable "logstore_append_meta" {
  type        = bool
  description = "Determines whether to append log meta automatically. The meta includes log receive time and client IP address."
  default     = true
}

variable "logstore_auto_split" {
  type        = bool
  description = "Determines whether to automatically split a shard."
  default     = true
}

variable "logstore_max_split_shard_count" {
  type        = number
  description = "The maximum number of shards for automatic split, which is in the range of 1 to 256. You must specify this parameter when autoSplit is true."
  default     = 64
}

variable "logstore_enable_web_tracking" {
  type        = bool
  description = "Whether open webtracking. webtracking network tracing, support the collection of HTML log, H5, Ios and android platforms."
  default     = false
}

variable "logstore_hot_ttl" {
  type        = number
  description = "The ttl of hot storage. Default to 30, at least 30, hot storage ttl must be less than ttl."
  default     = 30
}

variable "logstore_infrequent_access_ttl" {
  type        = number
  description = "Low frequency storage time."
  default     = null
}

variable "logstore_retention_period" {
  type        = number
  description = "The data retention time (in days). Valid values: [1-3650]. Default to 30. Log store data will be stored permanently when the value is 3650."
  default     = 180
}

variable "logstore_mode" {
  type        = string
  description = "The mode of storage. Must be standard or query, lite"
  default     = "standard"
}

variable "logstore_shard_count" {
  type        = number
  description = "The number of shards in this log store."
  default     = 2
}
