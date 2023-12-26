##Module      : DOMAIN IDENTITY
## Description : Terraform module to create domain identity using domain
output "domain_identity_arn" {
  value       = aws_ses_domain_identity.default[0].arn
  description = "ARN of the SES domain identity."
}

output "id" {
  value       = try(aws_ses_domain_identity.default[0].id, "")
  description = "The domain name of the domain identity."
}

output "iam_access_key_secret" {
  description = "The access key secret."
  value       = try(aws_iam_access_key.default[0].secret, "")
  sensitive   = true
}
output "iam_access_key_id" {
  description = "The access key ID."
  value       = try(aws_iam_access_key.default[0].id, "")
}