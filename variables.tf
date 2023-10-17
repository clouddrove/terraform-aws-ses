#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-ses"
  description = "Terraform current module repo"
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'"
}

variable "emails" {
  type        = list(string)
  default     = []
  description = "Emails list to use for SES."
}

#Module      : DOMAIN IDENTITY
#Description : Terraform domain identity module variables.
variable "domain" {
  type        = string
  default     = ""
  description = "Domain to use for SES."
}

#Module      : SMTP IAM USER
#Description : Terraform smtp Iam user module variables.
variable "iam_name" {
  type        = string
  default     = ""
  description = "IAM username."
}

variable "enable_verification" {
  type        = bool
  default     = false
  description = "Control whether or not to verify SES DNS records."
}

variable "enable_mail_from" {
  type        = bool
  default     = false
  description = "Control whether or not to enable mail from domain."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Boolean indicating whether or not to create sns module."
}

variable "enable_domain" {
  type        = bool
  default     = true
  description = "Control whether or not to enable domain identity for AWS SES."
}

variable "enable_email" {
  type        = bool
  default     = false
  description = "Control whether or not to enable email identity for AWS SES."
}

variable "enable_mx" {
  type        = bool
  default     = false
  description = "Control whether or not to enable mx DNS recodrds."
}

variable "enable_spf_domain" {
  type        = bool
  default     = false
  description = "Control whether or not to enable enable spf domain."
}

variable "enable_filter" {
  type        = bool
  default     = false
  description = "Control whether or not to enable receipt filter."
}

variable "enable_policy" {
  type        = bool
  default     = false
  description = "Control whether identity policy create for SES."
}

variable "enable_template" {
  type        = bool
  default     = false
  description = "Control whether create a template for emails."
}

variable "mail_from_domain" {
  type        = string
  default     = ""
  description = "Subdomain (of the route53 zone) which is to be used as MAIL FROM address."
}

variable "zone_id" {
  type        = string
  default     = ""
  description = "Route53 host zone ID to enable SES."
}

variable "filter_cidr" {
  type        = string
  default     = ""
  description = "The IP address or address range to filter, in CIDR notation."
}

variable "filter_policy" {
  type        = string
  default     = ""
  description = "Block or Allow filter."
}

variable "template_subject" {
  type        = string
  default     = ""
  description = "The subject line of the email."
}

variable "template_html" {
  type        = string
  default     = ""
  description = "The HTML body of the email. Must be less than 500KB in size, including both the text and HTML parts."
}

variable "text" {
  type        = string
  default     = ""
  description = "The email body that will be visible to recipients whose email clients do not display HTML."
}

variable "txt_type" {
  type        = string
  default     = "TXT"
  description = "Txt type for Record Set."
}

variable "mx_type" {
  type        = string
  default     = "MX"
  description = "MX type for Record Set."
}

variable "cname_type" {
  type        = string
  default     = "CNAME"
  description = "CNAME type for Record Set."
}

variable "spf_domain_name" {
  type    = string
  default = "spf_domain"
}
variable "ses_verification_name" {
  type    = string
  default = "ses_verification"
}