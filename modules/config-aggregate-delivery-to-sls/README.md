The module creates an Config aggregate delivery channel to deliver configuration changes, configuration snapshot and non compliant notification to SLS project.

## Prerequisites

Enabled Alicloud Config and created config globle aggregate in logarchive account.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.229.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.229.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_config_aggregate_delivery.log_archive](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/config_aggregate_delivery) | resource |
| [alicloud_log_project.log_archive](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_log_store.log_archive](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/log_store) | resource |
| [alicloud_account.log_archive](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_log_projects.log_archive](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/log_projects) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aggregator_id"></a> [aggregator\_id](#input\_aggregator\_id) | Config aggregator ID. | `string` | n/a | yes |
| <a name="input_configuration_item_change_notification"></a> [configuration\_item\_change\_notification](#input\_configuration\_item\_change\_notification) | Indicates whether the specified destination receives resource change logs. If the value of this parameter is true, Cloud Config delivers the resource change logs to OSS when the configurations of the resources change. | `bool` | `true` | no |
| <a name="input_configuration_snapshot"></a> [configuration\_snapshot](#input\_configuration\_snapshot) | Indicates whether the specified destination receives scheduled resource snapshots. Cloud Config delivers scheduled resource snapshots at 04:00Z and 16:00Z to OSS every day. The time is displayed in UTC. | `bool` | `true` | no |
| <a name="input_delivery_channel_condition"></a> [delivery\_channel\_condition](#input\_delivery\_channel\_condition) | The rule that is attached to the delivery channel. | `string` | `null` | no |
| <a name="input_delivery_channel_description"></a> [delivery\_channel\_description](#input\_delivery\_channel\_description) | The description of the config delivery channel. | `string` | `null` | no |
| <a name="input_delivery_channel_name"></a> [delivery\_channel\_name](#input\_delivery\_channel\_name) | The name of the config delivery channel. | `string` | n/a | yes |
| <a name="input_existed_project_region"></a> [existed\_project\_region](#input\_existed\_project\_region) | When use an existed SLS project, you should specify the region of the project. | `string` | `null` | no |
| <a name="input_logstore_append_meta"></a> [logstore\_append\_meta](#input\_logstore\_append\_meta) | Determines whether to append log meta automatically. The meta includes log receive time and client IP address. | `bool` | `true` | no |
| <a name="input_logstore_auto_split"></a> [logstore\_auto\_split](#input\_logstore\_auto\_split) | Determines whether to automatically split a shard. | `bool` | `true` | no |
| <a name="input_logstore_enable_web_tracking"></a> [logstore\_enable\_web\_tracking](#input\_logstore\_enable\_web\_tracking) | Whether open webtracking. webtracking network tracing, support the collection of HTML log, H5, Ios and android platforms. | `bool` | `false` | no |
| <a name="input_logstore_hot_ttl"></a> [logstore\_hot\_ttl](#input\_logstore\_hot\_ttl) | The ttl of hot storage. Default to 30, at least 30, hot storage ttl must be less than ttl. | `number` | `30` | no |
| <a name="input_logstore_infrequent_access_ttl"></a> [logstore\_infrequent\_access\_ttl](#input\_logstore\_infrequent\_access\_ttl) | Low frequency storage time. | `number` | `null` | no |
| <a name="input_logstore_max_split_shard_count"></a> [logstore\_max\_split\_shard\_count](#input\_logstore\_max\_split\_shard\_count) | The maximum number of shards for automatic split, which is in the range of 1 to 256. You must specify this parameter when autoSplit is true. | `number` | `64` | no |
| <a name="input_logstore_mode"></a> [logstore\_mode](#input\_logstore\_mode) | The mode of storage. Must be standard or query, lite | `string` | `"standard"` | no |
| <a name="input_logstore_name"></a> [logstore\_name](#input\_logstore\_name) | The name of the SLS logstore. When use an existed SLS project, you should specify an existed logstore name. | `string` | n/a | yes |
| <a name="input_logstore_retention_period"></a> [logstore\_retention\_period](#input\_logstore\_retention\_period) | The data retention time (in days). Valid values: [1-3650]. Default to 30. Log store data will be stored permanently when the value is 3650. | `number` | `180` | no |
| <a name="input_logstore_shard_count"></a> [logstore\_shard\_count](#input\_logstore\_shard\_count) | The number of shards in this log store. | `number` | `2` | no |
| <a name="input_non_compliant_notification"></a> [non\_compliant\_notification](#input\_non\_compliant\_notification) | Indicates whether the specified destination receives resource non-compliance events. If the value of this parameter is true, Cloud Config delivers resource non-compliance events to Log Service when resources are evaluated as non-compliant. | `bool` | `true` | no |
| <a name="input_project_description"></a> [project\_description](#input\_project\_description) | The description of the SLS project. | `string` | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the SLS project. When use an existed SLS project, you should specify the existed project name. | `string` | n/a | yes |
| <a name="input_project_resource_group_id"></a> [project\_resource\_group\_id](#input\_project\_resource\_group\_id) | The ID of the resource group to which the project belongs. | `string` | `null` | no |
| <a name="input_project_tags"></a> [project\_tags](#input\_project\_tags) | A mapping of tags to assign to the sls project. | `map(string)` | `{}` | no |
| <a name="input_use_existed_project"></a> [use\_existed\_project](#input\_use\_existed\_project) | Whether to use an existed SLS project. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_delivery_channel_id"></a> [delivery\_channel\_id](#output\_delivery\_channel\_id) | The ID of the delivery method. This parameter is required when you modify a delivery method. |
| <a name="output_logstore_create_time"></a> [logstore\_create\_time](#output\_logstore\_create\_time) | The create time of the sls logstore. If you use an existed SLS project, this value is null. |
| <a name="output_logstore_id"></a> [logstore\_id](#output\_logstore\_id) | The id of the sls logstore. If you use an existed SLS project, this value is null. |
| <a name="output_logstore_shards"></a> [logstore\_shards](#output\_logstore\_shards) | The shard attribute of the sls logstore. If you use an existed SLS project, this value is null. |
| <a name="output_project_create_time"></a> [project\_create\_time](#output\_project\_create\_time) | The create time of the sls project. If you use an existed SLS project, this value is null. |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | The id of the sls project. If you use an existed SLS project, this value is null. |
<!-- END_TF_DOCS -->