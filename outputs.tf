output "domain_identity_arn" {
  description = "ARN of the SES domain identity"
  value       = "${aws_ses_domain_identity.domain.arn}"
}
