## Managed By : CloudDrove
## Description : This Script is used to create SES Domain Identity, Identity Verification, Domain Dkim And Verification With Route53.
## Copyright @ CloudDrove. All Right Reserved.

locals {
  # some ses resources don't allow for the terminating '.' in the domain name
  # so use a replace function to strip it out
  stripped_domain_name      = replace(var.domain, "/[.]$/", "")
  stripped_mail_from_domain = replace(var.mail_from_domain, "/[.]$/", "")
  dash_domain               = replace(var.domain, ".", "-")
}

#Module      : DOMAIN IDENTITY
#Description : Terraform module to create domain identity using domain
resource "aws_ses_domain_identity" "default" {
  count  = var.enable_domain ? 1 : 0
  domain = var.domain
}

###DNS VERIFICATION#######

#Module      : DOMAIN IDENTITY VERIFICATION
#Description : Terraform module to verify domain identity using domain
resource "aws_ses_domain_identity_verification" "default" {
  count      = var.enable_verification ? 1 : 0
  domain     = aws_ses_domain_identity.default[count.index].id
  depends_on = [aws_route53_record.ses_verification]
}

#Module      : DOMAIN IDENTITY VERIFICATION ROUTE53
#Description : Terraform module to record of Route53 for verify domain identity using domain
resource "aws_route53_record" "ses_verification" {
  count   = var.zone_id != "" ? 1 : 0
  zone_id = var.zone_id
  name    = "_amazonses"
  type    = var.txt_type
  ttl     = "600"
  records = [aws_ses_domain_identity.default[count.index].verification_token]
}

# Module      : DOMAIN DKIM
# Description : Terraform module which creates Domain DKIM resource on AWS
resource "aws_ses_domain_dkim" "default" {
  domain = aws_ses_domain_identity.default[0].domain
}

###DKIM VERIFICATION#######

#Module      : DOMAIN DKIM VERIFICATION
#Description : Terraform module to verify domain DKIM on AWS
resource "aws_route53_record" "dkim" {
  count   = var.zone_id != "" ? 3 : 0
  zone_id = var.zone_id
  name    = format("%s._domainkey.%s", element(aws_ses_domain_dkim.default.dkim_tokens, count.index), var.domain)
  type    = var.cname_type
  ttl     = 600
  records = [format("%s.dkim.amazonses.com", element(aws_ses_domain_dkim.default.dkim_tokens, count.index))]
}

###SES MAIL FROM DOMAIN#######

#Module      : DOMAIN MAIL FROM
#Description : Terraform module to create domain mail from on AWS
resource "aws_ses_domain_mail_from" "default" {
  count            = var.enable_mail_from ? 1 : 0
  domain           = aws_ses_domain_identity.default.*.domain
  mail_from_domain = local.stripped_mail_from_domain
}

###SPF validaton record#######

#Module      : SPF RECORD
#Description : Terraform module to create record of SPF for domain mail from
resource "aws_route53_record" "spf_mail_from" {
  count   = var.enable_mail_from ? 1 : 0
  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.default[count.index].mail_from_domain
  type    = var.txt_type
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}

#Module      : SPF RECORD
#Description : Terraform module to create record of SPF for domain
resource "aws_route53_record" "spf_domain" {
  count   = var.enable_spf_domain && var.zone_id != "" ? 1 : 0
  zone_id = var.zone_id
  name    = var.domain
  type    = var.txt_type
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}

###Sending MX Record#######

data "aws_region" "current" {}

#Module      : MX RECORD
#Description : Terraform module to create record of MX for domain mail from
resource "aws_route53_record" "mx_send_mail_from" {
  count   = var.zone_id != "" && var.enable_mail_from ? 1 : 0
  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.default[count.index].mail_from_domain
  type    = var.mx_type
  ttl     = "600"
  records = [format("10 feedback-smtp.%s.amazonses.com", data.aws_region.current.name)]
}

###Receiving MX Record#######

#Module      : MX RECORD
#Description : Terraform module to create record of MX for receipt
resource "aws_route53_record" "mx_receive" {
  count   = var.enable_mx && var.zone_id != "" ? 1 : 0
  zone_id = var.zone_id
  name    = var.domain
  type    = var.mx_type
  ttl     = "600"
  records = [format("10 inbound-smtp.%s.amazonaws.com", data.aws_region.current.name)]
}

#Module      : SES FILTER
#Description : Terraform module to create receipt filter on AWS
resource "aws_ses_receipt_filter" "default" {
  count  = var.enable_filter ? 1 : 0
  name   = var.filter_name
  cidr   = var.filter_cidr
  policy = var.filter_policy
}

#Module      : SES BUCKET POLICY
#Description : Document of Policy to create Identity policy of SES
data "aws_iam_policy_document" "document" {
  statement {
    actions   = ["SES:SendEmail", "SES:SendRawEmail"]
    resources = [aws_ses_domain_identity.default[0].arn]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
  }
}

#Module      : SES IDENTITY POLICY
#Description : Terraform module to create ses identity policy on AWS
resource "aws_ses_identity_policy" "default" {
  count    = var.enable_policy ? 1 : 0
  identity = aws_ses_domain_identity.default.*.arn
  name     = var.policy_name
  policy   = data.aws_iam_policy_document.document.json
}

#Module      : SES TEMPLATE
#Description : Terraform module to create template on AWS
resource "aws_ses_template" "default" {
  count   = var.enable_template ? 1 : 0
  name    = var.template_name
  subject = var.template_subject
  html    = var.template_html
  text    = var.text
}


###SMTP DETAILS#######

# Module      : IAM USER
# Description : Terraform module which creates SMTP Iam user resource on AWS
resource "aws_iam_user" "default" {
  count = var.iam_name != "" ? 1 : 0
  name  = var.iam_name
}

# Module      : IAM ACCESS KEY
# Description : Terraform module which creates SMTP Iam access key resource on AWS
resource "aws_iam_access_key" "default" {
  count = var.iam_name != "" ? 1 : 0
  user  = join("", aws_iam_user.default.*.name)
}

# Module      : IAM USER POLICY
# Description : Terraform module which creates SMTP Iam user policy resource on AWS
resource "aws_iam_user_policy" "default" {
  count  = var.iam_name != "" ? 1 : 0
  name   = var.iam_name
  user   = join("", aws_iam_user.default.*.name)
  policy = data.aws_iam_policy_document.allow_iam_name_to_send_emails.json
}

# Module      : IAM USER POLICY DOCUMENT
# Description : Terraform module which creates SMTP Iam user policy document resource on AWS
data "aws_iam_policy_document" "allow_iam_name_to_send_emails" {
  statement {
    actions   = ["ses:SendRawEmail"]
    resources = ["*"]
  }
}
