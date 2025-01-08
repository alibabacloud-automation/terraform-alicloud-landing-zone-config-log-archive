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
    enabled               = true
    delivery_channel_name = "landingzone-enterprise"
    # The name must be unique in SLS. In this example, a random string is used as the name suffix to avoid duplication.
    # It is recommended that you use a unique fixed value as the name when you use.
    project_name  = format("landingzone-config-%s", random_string.random.result)
    logstore_name = "landingzone-config"
  }
  delivery_to_oss = {
    enabled               = true
    delivery_channel_name = "landingzone-enterprise"
    # The name must be unique in OSS. In this example, a random string is used as the name suffix to avoid duplication.
    # It is recommended that you use a unique fixed value as the name when you use.
    bucket_name          = format("landingzone-config-%s", random_string.random.result)
    bucket_force_destroy = true
  }
}
