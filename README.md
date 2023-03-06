# ap-terraform-control-panel-iam

Creates IAM for the control panel to manage AWS resources in multiple accounts.

The module requires three providers:

- The account that hosts the cluster the control panel is installed on
- The data account
- The account that hosts the cluster the applications are on

These may all the same, all different or any combination in between. 

It assumes that a trust relationship between the cluster OIDC provider and other accounts already exists.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.71.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.71.0 |
| <a name="provider_aws.apps_account"></a> [aws.apps\_account](#provider\_aws.apps\_account) | ~> 3.71.0 |
| <a name="provider_aws.control_panel_account"></a> [aws.control\_panel\_account](#provider\_aws.control\_panel\_account) | ~> 3.71.0 |
| <a name="provider_aws.data_account"></a> [aws.data\_account](#provider\_aws.data\_account) | ~> 3.71.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_account_role"></a> [app\_account\_role](#module\_app\_account\_role) | github.com/ministryofjustice/ap-terraform-iam-roles.git//assumable-role-federated-user | v1.1.0 |
| <a name="module_control_panel_role"></a> [control\_panel\_role](#module\_control\_panel\_role) | github.com/ministryofjustice/ap-terraform-iam-roles.git//eks-role | v1.1.0 |
| <a name="module_data_account_role"></a> [data\_account\_role](#module\_data\_account\_role) | github.com/ministryofjustice/ap-terraform-iam-roles.git//assumable-role-federated-user | v1.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.allow_sts_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.manage_apps](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.manage_data_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_caller_identity.apps_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.data_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.allow_sts_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.manage_apps](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.manage_data_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.apps_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_control_panel_service_account"></a> [control\_panel\_service\_account](#input\_control\_panel\_service\_account) | The service account for the control panel | `string` | n/a | yes |
| <a name="input_provider_url"></a> [provider\_url](#input\_provider\_url) | URL of the cluster OIDC Provider | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | The prefix for the resources this control panel IAM can manage | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to IAM role resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->