Terraform module to implements Multi-Account Config Log Archive.

# terraform-alicloud-landing-zone-config-log-archive

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-landing-zone-config-log-archive/blob/main/README-CN.md)

A sophisticated compliance auditing solution can help enterprises detect potential security vulnerabilities and risks so that enterprises can take measures to solve problems at the earliest opportunity and prevent information security incidents. This improves the security and reliability of enterprises. At the same time, enterprises can use compliance auditing to prove enterprise compliance to regulators and customers. This can enhance the credibility and competitiveness of enterprises. 

This Module is based on the delivery function of Config service to achieve centralized collection of resource configuration audit logs under multiple accounts. You can deliver configuration audit logs such as resource change logs, resource snapshots, and non-compliance information to SLS or OSS under a logarchive account. This helps construct a centralized compliance view and alert system, enhancing the visibility and controllability of the central management team's work, effectively exerting regulatory efficacy, and mitigating potential risks.

![Structure](https://raw.githubusercontent.com/alibabacloud-automation/terraform-alicloud-landing-zone-config-log-archive/main/pictures/structure.png)

## Prerequisites

- Built multi-account structure in Resource Directory.
- Enabled OSS service and SLS service in logarchive account.

## Usage

<div style="display: block;margin-bottom: 40px;"><div class="oics-button" style="float: right;position: absolute;margin-bottom: 10px;">
  <a href="https://api.aliyun.com/terraform?source=Module&activeTab=document&sourcePath=alibabacloud-automation%3A%3Alanding-zone-config-log-archive&spm=docs.m.alibabacloud-automation.landing-zone-config-log-archive&intl_lang=EN_US" target="_blank">
    <img alt="Open in AliCloud" src="https://img.alicdn.com/imgextra/i1/O1CN01hjjqXv1uYUlY56FyX_!!6000000006049-55-tps-254-36.svg" style="max-height: 44px; max-width: 100%;">
  </a>
</div></div>

You can use this in your terraform template with the following steps.

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

## Examples

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