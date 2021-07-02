provider "aws" {
  region = "eu-west-1"
}

module "ses" {
  source = "./../"

  domain   = "clouddrove.com"
  iam_name = "ses-user"

  enable_verification = false
  enable_mx           = false
  enable_spf_domain   = false
}
