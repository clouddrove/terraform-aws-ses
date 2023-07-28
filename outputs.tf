# Module      : DOMAIN IDENTITY
# Description : Terraform module to create domain identity using domain
output "domain_identity_arn" {
  value       = aws_ses_domain_identity.default[0].arn
  description = "ARN of the SES domain identity."
}

output "id" {
  value       = try(aws_ses_domain_identity_verification.default[0].id, "")
  description = "The domain name of the domain identity."
}