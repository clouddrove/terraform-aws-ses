provider "aws" {
  region = "us-east-1"
}

module "ses" {
  source   = "git::https://github.com/clouddrove/terraform-aws-ses.git?ref=tags/0.11.0"
  domain   = "clouddrove.com"
  iam_name = "ses-user"
  zone_id  = "Z1EHJSMFKPDUS3"
}
