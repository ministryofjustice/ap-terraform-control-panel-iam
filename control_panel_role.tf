###############################################################################
# Control panel EKS role
#
# This is the role that the control panel is associated with via IRSA. It's only
# purpose is to permit the the control panel to assume operation specific roles
# in the data account and the application cluster account.
###############################################################################

module "control_panel_role" {
  source                   = "git@github.com:ministryofjustice/ap-terraform-iam-roles.git//eks-role?ref=v1.1.0"
  role_name_prefix         = "ControlPanelFederatedID"
  role_description         = "Role to identify the control panel for ${var.resource_prefix}"
  provider_url             = var.provider_url
  role_policy_arns         = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
  cluster_service_accounts = [var.control_panel_service_account]

  tags = var.tags

  providers = {
    aws = aws.control_panel_account
  }

}

###############################################################################
# Control panel EKS role policy
#
# This policy permits attempting to assume the data account and app account
# management roles.
###############################################################################

resource "aws_iam_policy" "allow_sts_policy" {
  name_prefix = "AllowSTSControlPanel"
  description = "Permit control panel for ${var.resource_prefix} to assume other roles"
  policy      = data.aws_iam_policy_document.allow_sts_policy.json
  tags        = var.tags

  provider = aws.control_panel_account
}

data "aws_iam_policy_document" "allow_sts_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    resources = [
      module.app_account_role.iam_role_arn,
      module.data_account_role.iam_role_arn
    ]
    effect = "Allow"
  }
}
