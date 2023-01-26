output "domain_identity_arn" {
  value       = module.ses.domain_identity_arn
  description = "ARN of the SES domain identity"
}

output "id" {
  value       = module.ses.*.id
  description = "The domain name of the domain identity."
}
