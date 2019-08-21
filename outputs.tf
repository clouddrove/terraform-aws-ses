# Module      : DOMAIN IDENTITY
# Description : Terraform module to create domain identity using domain
output "domain_identity_arn" {
  value = concat(
    aws_ses_domain_identity.default.*.arn
  )[0]
  description = "ARN of the SES domain identity."
}