module "example" {
  source                   = "./.."
  cluster_oidc_issurer_url = "foo.example.com"
  resource_prefix          = "test-prefix"
}
