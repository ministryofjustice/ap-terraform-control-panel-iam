#################################################################################################
# Cross account IRSA role for the control panel
#################################################################################################

module "iam_assumable_role_control_panel_api" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "4.3.0"
  create_role                   = true
  role_name_prefix              = "dev_control_panel_api"
  provider_url                  = var.cluster_oidc_issurer_url
  role_policy_arns              = [aws_iam_policy.control_panel_api.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:cpanel:cpanel-frontend"]

}

resource "aws_iam_policy" "control_panel_api" {
  name        = "dev_eks_control_panel_api"
  description = "Control Panel policy for ${var.resource_prefix} EKS cluster"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CanCreateBuckets",
      "Effect": "Allow",
      "Action": [
        "s3:CreateBucket",
        "s3:PutBucketLogging",
        "s3:PutBucketPublicAccessBlock",
        "s3:PutEncryptionConfiguration",
        "s3:PutBucketVersioning",
        "s3:PutLifecycleConfiguration"
      ],
      "Resource": [
        "arn:aws:s3:::${var.resource_prefix}-*"
      ]
    },
    {
      "Sid": "CanTagBuckets",
      "Effect": "Allow",
      "Action": [
        "s3:GetBucketTagging",
        "s3:PutBucketTagging"
      ],
      "Resource": [
        "arn:aws:s3:::${var.resource_prefix}-*"
      ]
    },
    {
      "Sid": "CanCreateIAMPolicies",
      "Effect": "Allow",
      "Action": [
        "iam:CreatePolicy"
      ],
      "Resource": [
        "arn:aws:iam::111111111111:policy/${var.resource_prefix}-*"
      ]
    },
    {
      "Sid": "CanDeleteIAMPolicies",
      "Effect": "Allow",
      "Action": [
        "iam:DeletePolicy"
      ],
      "Resource": [
        "arn:aws:iam::111111111111:policy/${var.resource_prefix}-*"
      ]
    },
    {
      "Sid": "CanDetachPolicies",
      "Effect": "Allow",
      "Action": [
        "iam:ListEntitiesForPolicy",
        "iam:DetachGroupPolicy",
        "iam:DetachRolePolicy",
        "iam:DetachUserPolicy"
      ],
      "Resource": [
        "arn:aws:iam::111111111111:*"
      ]
    },
    {
      "Sid": "CanAttachPolicy",
      "Effect": "Allow",
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "arn:aws:iam::111111111111:role/${var.resource_prefix}_user_*",
        "arn:aws:iam::111111111111:role/${var.resource_prefix}_app_*"
      ]
    },
    {
      "Sid": "CanCreateRoles",
      "Effect": "Allow",
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::111111111111:role/${var.resource_prefix}_user_*",
        "arn:aws:iam::111111111111:role/${var.resource_prefix}_app_*"
      ]
    },
    {
      "Sid": "CanDeleteRoles",
      "Effect": "Allow",
      "Action": [
        "iam:GetRole",
        "iam:DeleteRole",
        "iam:ListAttachedRolePolicies",
        "iam:ListRolePolicies",
        "iam:DetachRolePolicy",
        "iam:DeleteRolePolicy"
      ],
      "Resource": [
        "arn:aws:iam::111111111111:role/${var.resource_prefix}_user_*",
        "arn:aws:iam::111111111111:role/${var.resource_prefix}_app_*"
      ]
    },
    {
      "Sid": "CanReadRolesInlinePolicies",
      "Effect": "Allow",
      "Action": [
        "iam:GetRolePolicy"
      ],
      "Resource": [
        "arn:aws:iam::111111111111:role/${var.resource_prefix}_user_*",
        "arn:aws:iam::111111111111:role/${var.resource_prefix}_app_*"
      ]
    },
    {
      "Sid": "CanUpdateRolesInlinePolicies",
      "Effect": "Allow",
      "Action": [
        "iam:PutRolePolicy"
      ],
      "Resource": [
        "arn:aws:iam::111111111111:role/${var.resource_prefix}_user_*",
        "arn:aws:iam::111111111111:role/${var.resource_prefix}_app_*"
      ]
    },
    {
      "Sid": "CanUpdateAssumeRolesPolicies",
      "Effect": "Allow",
      "Action": [
        "iam:UpdateAssumeRolePolicy"
      ],
      "Resource": [
        "arn:aws:iam::111111111111:role/${var.resource_prefix}_user_*"
      ]
    },
    {
      "Sid": "CanCreateAndDeleteSSMParameters",
      "Effect": "Allow",
      "Action": [
        "ssm:PutParameter",
        "ssm:DeleteParameter",
        "ssm:GetParameterHistory",
        "ssm:GetParametersByPath",
        "ssm:DeleteParameter",
        "ssm:DeleteParameters",
        "ssm:AddTagsToResource"
      ],
      "Resource": [
        "arn:aws:ssm:*:111111111111:parameter/${var.resource_prefix}*"
      ]
    },
    {
      "Sid": "CanListRoles",
      "Effect": "Allow",
      "Action": [
        "iam:ListRoles"
      ],
      "Resource": [
        "arn:aws:iam::111111111111:role/*"
      ]
    },
    {
      "Sid": "CanManagePolicies",
      "Effect": "Allow",
      "Action": [
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
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "arn:aws:iam::111111111111:policy/${var.resource_prefix}/group/*"
      ]
    },
    {
      "Sid": "CanManageSecrets",
      "Effect": "Allow",
      "Action": [
        "secretsmanager:CreateSecret",
        "secretsmanager:DescribeSecret",
        "secretsmanager:GetSecretValue",
        "secretsmanager:ListSecretVersionIds",
        "secretsmanager:TagResource",
        "secretsmanager:UntagResource",
        "secretsmanager:PutSecretValue",
        "secretsmanager:UpdateSecret",
        "secretsmanager:DeleteSecret"
      ],
      "Resource": [
        "arn:aws:secretsmanager:blah:111111111111:secret:dev/apps/*"
      ]
    }
  ]
}
EOF

}
