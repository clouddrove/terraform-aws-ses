output "domain_identity_arn" {
  value       = module.ses.domain_identity_arn
  description = "ARN of the SES domain identity"
}

output "id" {
  value       = module.ses[*].id
  description = "The domain name of the domain identity."
}

output "iam_access_key_secret" {
  value       = module.ses.iam_access_key_secret
  sensitive   = true
  description = "The access key secret."
}
output "iam_access_key_id" {
  value       = module.ses.iam_access_key_id
  description = "The access key ID."

}