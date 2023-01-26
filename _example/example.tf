provider "aws" {
  region = "eu-west-1"
}

module "ses" {
  source = "./../"

  name        = "ses"
  environment = "example"
  label_order = ["name", "environment"]

  domain   = "clouddrove.com"
  iam_name = "ses-user1"

  enable_verification = false
  enable_mx           = false
  enable_spf_domain   = false
}
