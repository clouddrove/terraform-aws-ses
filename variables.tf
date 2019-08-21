variable "domain" {
  default     = ""
  description = "Domain to use for SES"
}

variable "iam_name" {
  default     = ""
  description = "iam username"
}

variable "zone_id" {
  description = "Route 53 zone ID for the SES domain verification"
  default     = ""
}

variable "ses_records" {
  description = "Additional entries which are added to the _amazonses record"
  default     = []
}
