The module creates an Config aggregate delivery channel to deliver configuration changes, configuration snapshot to OSS bucket.

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
| [alicloud_oss_bucket.log_archive](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_account.log_archive](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aggregator_id"></a> [aggregator\_id](#input\_aggregator\_id) | Config aggregator ID. | `string` | n/a | yes |
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket. When use an existed OSS bucket, you should specify the existed bucket name. | `string` | n/a | yes |
| <a name="input_bucket_redundancy_type"></a> [bucket\_redundancy\_type](#input\_bucket\_redundancy\_type) | The redundancy type to enable. Can be "LRS", and "ZRS". | `string` | `"ZRS"` | no |
| <a name="input_bucket_resource_group_id"></a> [bucket\_resource\_group\_id](#input\_bucket\_resource\_group\_id) | The ID of the resource group to which the bucket belongs. | `string` | `null` | no |
| <a name="input_bucket_storage_class"></a> [bucket\_storage\_class](#input\_bucket\_storage\_class) | The storage class to apply. Can be "Standard", "IA", "Archive", "ColdArchive" and "DeepColdArchive". | `string` | `"Standard"` | no |
| <a name="input_bucket_tags"></a> [bucket\_tags](#input\_bucket\_tags) | A mapping of tags to assign to the oss bucket. | `map(string)` | `{}` | no |
| <a name="input_configuration_item_change_notification"></a> [configuration\_item\_change\_notification](#input\_configuration\_item\_change\_notification) | Indicates whether the specified destination receives resource change logs. If the value of this parameter is true, Cloud Config delivers the resource change logs to OSS when the configurations of the resources change. | `bool` | `true` | no |
| <a name="input_configuration_snapshot"></a> [configuration\_snapshot](#input\_configuration\_snapshot) | Indicates whether the specified destination receives scheduled resource snapshots. Cloud Config delivers scheduled resource snapshots at 04:00Z and 16:00Z to OSS every day. The time is displayed in UTC. | `bool` | `true` | no |
| <a name="input_delivery_channel_condition"></a> [delivery\_channel\_condition](#input\_delivery\_channel\_condition) | The rule that is attached to the delivery channel. | `string` | `null` | no |
| <a name="input_delivery_channel_description"></a> [delivery\_channel\_description](#input\_delivery\_channel\_description) | The description of the config delivery channel. | `string` | `null` | no |
| <a name="input_delivery_channel_name"></a> [delivery\_channel\_name](#input\_delivery\_channel\_name) | The name of the config delivery channel. | `string` | n/a | yes |
| <a name="input_existed_bucket_region"></a> [existed\_bucket\_region](#input\_existed\_bucket\_region) | When use an existed OSS bucket, you should specify the region of the bucket. | `string` | `null` | no |
| <a name="input_use_existed_bucket"></a> [use\_existed\_bucket](#input\_use\_existed\_bucket) | Whether to use an existed OSS bucket. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_creation_date"></a> [bucket\_creation\_date](#output\_bucket\_creation\_date) | The creation date of the bucket. If you use an existed OSS bucket, this value is null. |
| <a name="output_bucket_extranet_endpoint"></a> [bucket\_extranet\_endpoint](#output\_bucket\_extranet\_endpoint) | The extranet access endpoint of the bucket. If you use an existed OSS bucket, this value is null. |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | The id of the bucket. The value is the same as bucket name. |
| <a name="output_bucket_intranet_endpoint"></a> [bucket\_intranet\_endpoint](#output\_bucket\_intranet\_endpoint) | The intranet access endpoint of the bucket. If you use an existed OSS bucket, this value is null. |
| <a name="output_bucket_location"></a> [bucket\_location](#output\_bucket\_location) | The location of the bucket. If you use an existed OSS bucket, this value is null. |
| <a name="output_delivery_channel_id"></a> [delivery\_channel\_id](#output\_delivery\_channel\_id) | The ID of the delivery method. This parameter is required when you modify a delivery method. |
<!-- END_TF_DOCS -->