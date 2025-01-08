provider "alicloud" {
  alias  = "management_account"
  region = "cn-shanghai"
}

provider "alicloud" {
  alias  = "log_archive_account"
  region = "cn-shanghai"
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

module "config_log_archive" {
  source = "../../"

  providers = {
    alicloud.management_account  = alicloud.management_account
    alicloud.log_archive_account = alicloud.log_archive_account
  }

  aggregator_name        = "ResourceDirectory"
  aggregator_description = "Global aggregator created by terraform"
  delivery_to_sls = {
    enabled                                = true
    delivery_channel_name                  = "landingzone-enterprise"
    delivery_channel_description           = "Config aggregator delivery to SLS"
    delivery_channel_condition             = "[{\"filterType\":\"RuleRiskLevel\",\"value\":\"1\",\"multiple\":false}]"
    configuration_item_change_notification = true
    configuration_snapshot                 = true
    non_compliant_notification             = true
    use_existed_project                    = false
    existed_project_region                 = null
    # The name must be unique in SLS. In this example, a random string is used as the name suffix to avoid duplication.
    # It is recommended that you use a unique fixed value as the name when you use.
    project_name                   = format("landingzone-config-%s", random_string.random.result)
    project_description            = "Landing Zone Config Log Archive"
    project_resource_group_id      = null
    logstore_name                  = "landingzone-config"
    logstore_append_meta           = true
    logstore_auto_split            = true
    logstore_max_split_shard_count = 64
    logstore_enable_web_tracking   = false
    logstore_hot_ttl               = 30
    logstore_infrequent_access_ttl = null
    logstore_retention_period      = 180
    logstore_mode                  = "standard"
    logstore_shard_count           = 2
    project_tags = {
      "landingzone" : "logarchive"
    }
  }
  delivery_to_oss = {
    enabled                                = true
    delivery_channel_name                  = "landingzone-enterprise"
    delivery_channel_description           = "Config aggregator delivery to OSS"
    delivery_channel_condition             = null
    configuration_item_change_notification = true
    configuration_snapshot                 = true
    use_existed_bucket                     = false
    existed_bucket_region                  = null
    # The name must be unique in OSS. In this example, a random string is used as the name suffix to avoid duplication.
    # It is recommended that you use a unique fixed value as the name when you use.
    bucket_name              = format("landingzone-config-%s", random_string.random.result)
    bucket_storage_class     = "Standard"
    bucket_redundancy_type   = "ZRS"
    bucket_force_destroy     = true
    bucket_resource_group_id = null
    bucket_tags = {
      "landingzone" : "logarchive"
    }
  }
}
