variable "aggregator_name" {
  type        = string
  description = "The name of aggregator."
}

variable "aggregator_description" {
  type        = string
  description = "The description of aggregator."
  default     = null
}

variable "delivery_to_sls" {
  type = object({
    enabled                                = bool
    delivery_channel_name                  = string
    delivery_channel_description           = optional(string)
    delivery_channel_condition             = optional(string)
    configuration_item_change_notification = optional(bool, true)
    configuration_snapshot                 = optional(bool, true)
    non_compliant_notification             = optional(bool, true)
    use_existed_project                    = optional(bool, false)
    existed_project_region                 = optional(string)
    project_name                           = string
    project_description                    = optional(string)
    project_tags                           = optional(map(string))
    project_resource_group_id              = optional(string)
    logstore_name                          = string
    logstore_append_meta                   = optional(bool, true)
    logstore_auto_split                    = optional(bool, true)
    logstore_max_split_shard_count         = optional(number, 64)
    logstore_enable_web_tracking           = optional(bool, false)
    logstore_hot_ttl                       = optional(number, 30)
    logstore_infrequent_access_ttl         = optional(number)
    logstore_retention_period              = optional(number, 180)
    logstore_mode                          = optional(string, "standard")
    logstore_shard_count                   = optional(number, 2)
  })
  description = "Config delivery to sls configuration."
  default = {
    enabled                                = true
    delivery_channel_name                  = "landingzone-enterprise"
    configuration_item_change_notification = true
    configuration_snapshot                 = true
    non_compliant_notification             = true
    use_existed_project                    = false
    project_name                           = null
    project_tags = {
      "landingzone" : "logarchive"
    }
    logstore_name             = "landingzone-config"
    logstore_retention_period = 180
  }
}

variable "delivery_to_oss" {
  type = object({
    enabled                                = bool
    delivery_channel_name                  = string
    delivery_channel_description           = optional(string)
    delivery_channel_condition             = optional(string)
    configuration_item_change_notification = optional(bool, true)
    configuration_snapshot                 = optional(bool, true)
    use_existed_bucket                     = optional(bool, false)
    existed_bucket_region                  = optional(string)
    bucket_name                            = string
    bucket_storage_class                   = optional(string, "Standard")
    bucket_redundancy_type                 = optional(string, "ZRS")
    bucket_tags                            = optional(map(string))
    bucket_force_destroy                   = optional(bool, false)
    bucket_resource_group_id               = optional(string)
  })
  description = "Config delivery to oss configuration."
  default = {
    enabled                                = true
    delivery_channel_name                  = "landingzone-enterprise"
    configuration_item_change_notification = true
    configuration_snapshot                 = true
    use_existed_bucket                     = false
    bucket_name                            = null
    bucket_tags = {
      "landingzone" : "logarchive"
    }
    bucket_force_destroy = false
  }
}
