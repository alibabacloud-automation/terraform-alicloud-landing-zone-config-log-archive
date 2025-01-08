Terraform module to implements Multi-Account Config Log Archive.

# terraform-alicloud-landing-zone-config-log-archive

[English](https://github.com/alibabacloud-automation/terraform-alicloud-landing-zone-config-log-archive/blob/main/README.md) | 简体中文

在云环境下，企业的各中心管理团队面对云上多账号、多业务、多环境的复杂部署，需要一种从上而下的管理框架，能持续监管整个企业的安全合规性，及时发现问题、响应问题，从而规避可能存在的数据泄露、业务中断、成本溢出等IT管理风险。使用配置审计可以从上而下的实施统一的合规基线并强制管理，并且中心化的持续监测所有业务的合规状态。

本Module基于配置审计的投递功能，实现多账号下资源配置审计日志的中心化归集，您可以将资源变更日志、资源快照、资源不合规信息等配置审计日志，统一投递到日志账号下的SLS或OSS中，构建中心化的合规视图和报警体系，提升中心管理团队工作的可见性可控性，切实起到监管效力，规避潜在风险。

![Structure](https://raw.githubusercontent.com/alibabacloud-automation/terraform-alicloud-landing-zone-config-log-archive/main/pictures/structure-CN.png)

## 前提条件

- 基于资源目录构建多账号体系。
- 在日志账号中开通OSS和SLS。

## 使用方式

您可以通过以下步骤在您的 terraform 模板中使用它。

```hcl
provider "alicloud" {
  alias  = "management_account"
  region = "cn-shanghai"
}

provider "alicloud" {
  alias  = "log_archive_account"
  region = "cn-shanghai"
}

module "config_log_archive" {
  source = "alibabacloud-automation/landing-zone-config-log-archive/alicloud"

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
    # The name must be unique in SLS. In this example, timestamp is used as the name suffix to avoid duplication.
    # It is recommended that you use a unique fixed value as the name when you use.
    project_name                   = format("landingzone-config-%s", formatdate("YYYYMMDDhhmmss", timestamp()))
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
    # The name must be unique in OSS. In this example, timestamp is used as the name suffix to avoid duplication.
    # It is recommended that you use a unique fixed value as the name when you use.
    bucket_name              = format("landingzone-config-%s", formatdate("YYYYMMDDhhmmss", timestamp()))
    bucket_storage_class     = "Standard"
    bucket_redundancy_type   = "ZRS"
    bucket_force_destroy     = true
    bucket_resource_group_id = null
    bucket_tags = {
      "landingzone" : "logarchive"
    }
  }
}
```

## 示例

- [Basic Example](https://github.com/alibabacloud-automation/terraform-alicloud-landing-zone-config-log-archive/tree/main/examples/basic)
- [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-landing-zone-config-log-archive/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.229.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud.log_archive_account"></a> [alicloud.log\_archive\_account](#provider\_alicloud.log\_archive\_account) | >= 1.229.0 |
| <a name="provider_alicloud.management_account"></a> [alicloud.management\_account](#provider\_alicloud.management\_account) | >= 1.229.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_delivery_to_oss"></a> [delivery\_to\_oss](#module\_delivery\_to\_oss) | ./modules/config-aggregate-delivery-to-oss | n/a |
| <a name="module_delivery_to_sls"></a> [delivery\_to\_sls](#module\_delivery\_to\_sls) | ./modules/config-aggregate-delivery-to-sls | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_config_aggregator.log_archive](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/config_aggregator) | resource |
| [alicloud_config_configuration_recorder.log_archive](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/config_configuration_recorder) | resource |
| [alicloud_resource_manager_delegated_administrator.management](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/resource_manager_delegated_administrator) | resource |
| [alicloud_account.log_archive](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aggregator_description"></a> [aggregator\_description](#input\_aggregator\_description) | The description of aggregator. | `string` | `null` | no |
| <a name="input_aggregator_name"></a> [aggregator\_name](#input\_aggregator\_name) | The name of aggregator. | `string` | n/a | yes |
| <a name="input_delivery_to_oss"></a> [delivery\_to\_oss](#input\_delivery\_to\_oss) | Config delivery to oss configuration. | <pre>object({<br/>    enabled                                = bool<br/>    delivery_channel_name                  = string<br/>    delivery_channel_description           = optional(string)<br/>    delivery_channel_condition             = optional(string)<br/>    configuration_item_change_notification = optional(bool, true)<br/>    configuration_snapshot                 = optional(bool, true)<br/>    use_existed_bucket                     = optional(bool, false)<br/>    existed_bucket_region                  = optional(string)<br/>    bucket_name                            = string<br/>    bucket_storage_class                   = optional(string, "Standard")<br/>    bucket_redundancy_type                 = optional(string, "ZRS")<br/>    bucket_tags                            = optional(map(string))<br/>    bucket_force_destroy                   = optional(bool, false)<br/>    bucket_resource_group_id               = optional(string)<br/>  })</pre> | <pre>{<br/>  "bucket_force_destroy": false,<br/>  "bucket_name": null,<br/>  "bucket_tags": {<br/>    "landingzone": "logarchive"<br/>  },<br/>  "configuration_item_change_notification": true,<br/>  "configuration_snapshot": true,<br/>  "delivery_channel_name": "landingzone-enterprise",<br/>  "enabled": true,<br/>  "use_existed_bucket": false<br/>}</pre> | no |
| <a name="input_delivery_to_sls"></a> [delivery\_to\_sls](#input\_delivery\_to\_sls) | Config delivery to sls configuration. | <pre>object({<br/>    enabled                                = bool<br/>    delivery_channel_name                  = string<br/>    delivery_channel_description           = optional(string)<br/>    delivery_channel_condition             = optional(string)<br/>    configuration_item_change_notification = optional(bool, true)<br/>    configuration_snapshot                 = optional(bool, true)<br/>    non_compliant_notification             = optional(bool, true)<br/>    use_existed_project                    = optional(bool, false)<br/>    existed_project_region                 = optional(string)<br/>    project_name                           = string<br/>    project_description                    = optional(string)<br/>    project_tags                           = optional(map(string))<br/>    project_resource_group_id              = optional(string)<br/>    logstore_name                          = string<br/>    logstore_append_meta                   = optional(bool, true)<br/>    logstore_auto_split                    = optional(bool, true)<br/>    logstore_max_split_shard_count         = optional(number, 64)<br/>    logstore_enable_web_tracking           = optional(bool, false)<br/>    logstore_hot_ttl                       = optional(number, 30)<br/>    logstore_infrequent_access_ttl         = optional(number)<br/>    logstore_retention_period              = optional(number, 180)<br/>    logstore_mode                          = optional(string, "standard")<br/>    logstore_shard_count                   = optional(number, 2)<br/>  })</pre> | <pre>{<br/>  "configuration_item_change_notification": true,<br/>  "configuration_snapshot": true,<br/>  "delivery_channel_name": "landingzone-enterprise",<br/>  "enabled": true,<br/>  "logstore_name": "landingzone-config",<br/>  "logstore_retention_period": 180,<br/>  "non_compliant_notification": true,<br/>  "project_name": null,<br/>  "project_tags": {<br/>    "landingzone": "logarchive"<br/>  },<br/>  "use_existed_project": false<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aggregator_id"></a> [aggregator\_id](#output\_aggregator\_id) | The resource ID in terraform of Aggregator. |
| <a name="output_delivery_to_oss"></a> [delivery\_to\_oss](#output\_delivery\_to\_oss) | The outputs of config delivery that deliver logs to oss. |
| <a name="output_delivery_to_sls"></a> [delivery\_to\_sls](#output\_delivery\_to\_sls) | The outputs of config delivery that deliver logs to sls. |
| <a name="output_resource_manager_delegated_administrator_id"></a> [resource\_manager\_delegated\_administrator\_id](#output\_resource\_manager\_delegated\_administrator\_id) | The resource ID of Delegated Administrator. The value formats as <account\_id>:<service\_principal>. |
<!-- END_TF_DOCS -->