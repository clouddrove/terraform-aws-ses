## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cname\_type | CNAME type for Record Set. | `string` | `"CNAME"` | no |
| domain | Domain to use for SES. | `string` | `""` | no |
| emails | Emails list to use for SES. | `list(string)` | `[]` | no |
| enable\_domain | Control whether or not to enable domain identity for AWS SES. | `bool` | `true` | no |
| enable\_email | Control whether or not to enable email identity for AWS SES. | `bool` | `false` | no |
| enable\_filter | Control whether or not to enable receipt filter. | `bool` | `false` | no |
| enable\_mail\_from | Control whether or not to enable mail from domain. | `bool` | `false` | no |
| enable\_mx | Control whether or not to enable mx DNS recodrds. | `bool` | `false` | no |
| enable\_policy | Control whether identity policy create for SES. | `bool` | `false` | no |
| enable\_spf\_domain | Control whether or not to enable enable spf domain. | `bool` | `false` | no |
| enable\_template | Control whether create a template for emails. | `bool` | `false` | no |
| enabled | Boolean indicating whether or not to create sns module. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| filter\_cidr | The IP address or address range to filter, in CIDR notation. | `string` | `""` | no |
| filter\_policy | Block or Allow filter. | `string` | `""` | no |
| iam\_name | IAM username. | `string` | `""` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| mail\_from\_domain | Subdomain (of the route53 zone) which is to be used as MAIL FROM address. | `string` | `""` | no |
| managedby | ManagedBy, eg 'CloudDrove' | `string` | `"hello@clouddrove.com"` | no |
| mx\_type | MX type for Record Set. | `string` | `"MX"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-ses"` | no |
| spf\_domain\_name | n/a | `string` | `"spf_domain"` | no |
| template\_html | The HTML body of the email. Must be less than 500KB in size, including both the text and HTML parts. | `string` | `""` | no |
| template\_subject | The subject line of the email. | `string` | `""` | no |
| text | The email body that will be visible to recipients whose email clients do not display HTML. | `string` | `""` | no |
| txt\_type | Txt type for Record Set. | `string` | `"TXT"` | no |
| zone\_id | Route53 host zone ID to enable SES. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| domain\_identity\_arn | ARN of the SES domain identity. |
| iam\_access\_key\_id | The access key ID. |
| iam\_access\_key\_secret | The access key secret. |
| id | The domain name of the domain identity. |

