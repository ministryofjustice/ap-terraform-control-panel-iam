module "example" {
  source                        = "./.."
  control_panel_service_account = "iam-test:iam-test-sa"
  provider_url                  = "oidc.eks.eu-west-1.amazonaws.com/id/6F58D1C4FD8FAE6D3D9282A400EDCE79"
  resource_prefix               = "foo"

  providers = {
    aws.apps_account          = aws.a
    aws.control_panel_account = aws.b
    aws.data_account          = aws.c
  }
}
