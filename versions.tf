terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.71.0"
      configuration_aliases = [
        aws.apps_account,
        aws.data_account,
        aws.control_panel_account,
      ]
    }
  }

  required_version = ">= 1.2.2"
}
