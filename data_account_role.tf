###############################################################################
# Control panel data account role
#
# This is the role the control panel will assume to manage the data account
# resources.
###############################################################################

module "data_account_role" {
  source              = "github.com/ministryofjustice/ap-terraform-iam-roles.git//assumable-role-federated-user?ref=v1.1.0"
  role_name_prefix    = "ControlPanelDataManager"
  trusted_entity_arns = [module.control_panel_role.iam_role_arn]
  role_description    = "Role to permit the control panel for ${var.resource_prefix} to manage data account resources"
  role_policy_arns    = [aws_iam_policy.manage_data_account.arn]

  tags = var.tags

  providers = {
    aws = aws.data_account
  }

}

###############################################################################
# Control panel data account policy
#
# This is the policy attached to the role that will allow the control panel to
# manage the data account resources.
###############################################################################

resource "aws_iam_policy" "manage_data_account" {
  name_prefix = "ManageDataAccountResources"
  description = "Policy to permit management of ${var.resource_prefix} data account resources"
  policy      = data.aws_iam_policy_document.manage_data_account.json
  tags        = var.tags
  provider    = aws.data_account
}

data "aws_iam_policy_document" "manage_data_account" {

  statement {
    sid       = "CanCreateBuckets"
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.resource_prefix}-*"]

    actions = [
      "s3:CreateBucket",
      "s3:PutBucketLogging",
      "s3:PutBucketPublicAccessBlock",
      "s3:PutEncryptionConfiguration",
      "s3:PutBucketVersioning",
      "s3:PutLifecycleConfiguration",
    ]
  }

  statement {
    sid       = "CanTagBuckets"
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.resource_prefix}-*"]

    actions = [
      "s3:GetBucketTagging",
      "s3:PutBucketTagging",
    ]
  }

  statement {
    sid       = "CanCreateIAMPolicies"
    effect    = "Allow"
    resources = ["arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:policy/${var.resource_prefix}-*"]
    actions   = ["iam:CreatePolicy"]
  }

  statement {
    sid       = "CanDeleteIAMPolicies"
    effect    = "Allow"
    resources = ["arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:policy/${var.resource_prefix}-*"]
    actions   = ["iam:DeletePolicy"]
  }

  statement {
    sid       = "CanDetachPolicies"
    effect    = "Allow"
    resources = ["arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:*"]

    actions = [
      "iam:ListEntitiesForPolicy",
      "iam:DetachGroupPolicy",
      "iam:DetachRolePolicy",
      "iam:DetachUserPolicy",
    ]
  }

  statement {
    sid    = "CanAttachPolicy"
    effect = "Allow"

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:role/${var.resource_prefix}_user_*",
      "arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:role/${var.resource_prefix}_app_*",
    ]

    actions = ["iam:AttachRolePolicy"]
  }

  statement {
    sid    = "CanCreateRoles"
    effect = "Allow"

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:role/${var.resource_prefix}_user_*",
      "arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:role/${var.resource_prefix}_app_*",
    ]

    actions = ["iam:CreateRole"]
  }

  statement {
    sid    = "CanDeleteRoles"
    effect = "Allow"

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:role/${var.resource_prefix}_user_*",
      "arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:role/${var.resource_prefix}_app_*",
    ]

    actions = [
      "iam:GetRole",
      "iam:DeleteRole",
      "iam:ListAttachedRolePolicies",
      "iam:ListRolePolicies",
      "iam:DetachRolePolicy",
      "iam:DeleteRolePolicy",
    ]
  }

  statement {
    sid    = "CanReadRolesInlinePolicies"
    effect = "Allow"

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:role/${var.resource_prefix}_user_*",
      "arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:role/${var.resource_prefix}_app_*",
    ]

    actions = ["iam:GetRolePolicy"]
  }

  statement {
    sid    = "CanUpdateRolesInlinePolicies"
    effect = "Allow"

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:role/${var.resource_prefix}_user_*",
      "arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:role/${var.resource_prefix}_app_*",
    ]

    actions = ["iam:PutRolePolicy"]
  }

  statement {
    sid       = "CanUpdateAssumeRolesPolicies"
    effect    = "Allow"
    resources = ["arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:role/${var.resource_prefix}_user_*"]
    actions   = ["iam:UpdateAssumeRolePolicy"]
  }

  statement {
    sid       = "CanCreateAndDeleteSSMParameters"
    effect    = "Allow"
    resources = ["arn:aws:ssm:*:${data.aws_caller_identity.data_account.account_id}:parameter/${var.resource_prefix}*"]

    actions = [
      "ssm:PutParameter",
      "ssm:DeleteParameter",
      "ssm:GetParameterHistory",
      "ssm:GetParametersByPath",
      "ssm:DeleteParameter",
      "ssm:DeleteParameters",
      "ssm:AddTagsToResource",
    ]
  }

  statement {
    sid       = "CanListRoles"
    effect    = "Allow"
    resources = ["arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:role/*"]
    actions   = ["iam:ListRoles"]
  }

  statement {
    sid       = "CanManagePolicies"
    effect    = "Allow"
    resources = ["arn:aws:iam::${data.aws_caller_identity.data_account.account_id}:policy/${var.resource_prefix}/group/*"]

    actions = [
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListPolicyVersions",
      "iam:ListPolicies",
      "iam:ListEntitiesForPolicy",
      "iam:DetachRolePolicy",
      "iam:AttachRolePolicy",
    ]
  }
}
