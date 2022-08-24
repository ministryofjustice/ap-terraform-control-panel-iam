###############################################################################
# Control panel application account role
#
# This is the role the control panel will assume to manage the application
# account resources.
###############################################################################

module "app_account_role" {
  source              = "git@github.com:ministryofjustice/ap-terraform-iam-roles.git//assumable-role-federated-user?ref=v1.1.0"
  role_name_prefix    = "ControlPanelAppManager"
  trusted_entity_arns = [module.control_panel_role.iam_role_arn]
  role_description    = "Role to permit the control panel for ${var.resource_prefix} to manage application account resources"
  role_policy_arns    = [aws_iam_policy.manage_apps.arn]

  tags = var.tags

  providers = {
    aws = aws.apps_account
  }

}

###############################################################################
# Control panel application account policy
#
# This is the policy attached to the role that will allow the control panel to
# manage the application resources.
###############################################################################

resource "aws_iam_policy" "manage_apps" {
  name_prefix = "ManageApplicationResources"
  description = "Policy to permit management of ${var.resource_prefix} application resources"
  policy      = data.aws_iam_policy_document.manage_apps.json
  tags        = var.tags
  provider    = aws.apps_account
}

data "aws_iam_policy_document" "manage_apps" {

  statement {
    sid       = "CanManageSecrets"
    effect    = "Allow"
    resources = ["arn:aws:secretsmanager:${data.aws_region.apps_account.name}:${data.aws_caller_identity.apps_account.account_id}:secret:${var.resource_prefix}/apps/*"]

    actions = [
      "secretsmanager:CreateSecret",
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue",
      "secretsmanager:ListSecretVersionIds",
      "secretsmanager:TagResource",
      "secretsmanager:UntagResource",
      "secretsmanager:PutSecretValue",
      "secretsmanager:UpdateSecret",
      "secretsmanager:DeleteSecret",
    ]
  }

}
