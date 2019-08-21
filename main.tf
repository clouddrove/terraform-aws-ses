## Managed By : CloudDrove
## Copyright @ CloudDrove. All Right Reserved.

#Module      : DOMIAN IDENTITY
#Description : Provides an SES domain identity resource
resource "aws_ses_domain_identity" "domain" {
  domain = "${var.domain}"
}

#Module      : DOMIAN DKIM
#Description : Provides an SES domain DKIM generation resource.
resource "aws_ses_domain_dkim" "dkim" {
  domain = "${aws_ses_domain_identity.domain.domain}"
}

#Module      : IAM USER
#Description : Provides an IAM user.
resource "aws_iam_user" "iam_name" {
  name = "${var.iam_name}"
}

#Module      : ACCESS KEY
#Description : Provides an IAM access key.
#              This is a set of credentials that allow API requests to be made as an IAM user.
resource "aws_iam_access_key" "iam_name" {
  user = "${aws_iam_user.iam_name.name}"
}

#Module      : USER POLICY
#Description : Provides an IAM policy attached to a user.
resource "aws_iam_user_policy" "iam_name" {
  name   = "${var.iam_name}"
  user   = "${aws_iam_user.iam_name.name}"
  policy = "${data.aws_iam_policy_document.allow_iam_name_to_send_emails.json}"
}

data "aws_iam_policy_document" "allow_iam_name_to_send_emails" {
  statement {
    actions   = ["ses:SendRawEmail"]
    resources = ["*"]
  }
}

#Module      : Route53 VARIFICATION RECORD
#Description : Provides a Route53 record resource.
resource "aws_route53_record" "domain_amazonses_verification_record" {
  count   = "${var.zone_id != "" ? 1 : 0}"
  zone_id = "${var.zone_id}"
  name    = "_amazonses"
  type    = "TXT"
  ttl     = "3600"
  records = ["${aws_ses_domain_identity.domain.verification_token}"]
}

#Module      : Route53 DKIM RECORD
#Description : Provides a Route53 record resource.
resource "aws_route53_record" "domain_amazonses_dkim_record" {
  count   = "${var.zone_id != "" ? 3 : 0}"
  zone_id = "${var.zone_id}"
  name    = "${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = "3600"
  records = ["${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}
