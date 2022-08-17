output "app_account_role_arn" {
    description = "The ARN of the role for managing application account resources"
    value = module.app_account_role.iam_role_arn
}

output "control_panel_role_arn" {
    description = "The ARN of the role that identifies the control panel"
    value = module.control_panel_role.iam_role_arn
}

output "data_account_role_arn" {
    description = "The ARN of the role for managing data account resources"
    value = module.data_account_role.iam_role_arn
}
