terraform {
  required_version = ">= 1.3"
  required_providers {
    alicloud = {
      source                = "hashicorp/alicloud"
      version               = ">= 1.229.0"
      configuration_aliases = [alicloud.management_account, alicloud.log_archive_account]
    }
  }
}
