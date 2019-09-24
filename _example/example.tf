provider "aws" {
  region = "eu-west-1"
}

module "ses" {
  source = "git::https://github.com/clouddrove/terraform-aws-ses.git?ref=tags/0.12.1"

  domain   = "clouddrove.com"
  iam_name = "ses-user"
  zone_id  = "DSSTUJFGRTHD"

  enable_verification = true
  enable_mx           = false
  enable_spf_domain   = false
}