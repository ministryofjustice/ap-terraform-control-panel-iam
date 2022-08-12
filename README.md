# ap-terraform-control-panel-iam

Creates IAM for the control panel to manage AWS resources in multiple accounts.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.71.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.71.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_assumable_role_control_panel_api"></a> [iam\_assumable\_role\_control\_panel\_api](#module\_iam\_assumable\_role\_control\_panel\_api) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.control_panel_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_oidc_issurer_url"></a> [cluster\_oidc\_issurer\_url](#input\_cluster\_oidc\_issurer\_url) | This is the blah | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | More blah | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->