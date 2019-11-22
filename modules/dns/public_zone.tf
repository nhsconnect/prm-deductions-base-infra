resource "aws_route53_zone" "public" {
  name = "patient-deductions.nhs.uk"
}

# Save the zone IDs to use them in other infra projects
resource "aws_ssm_parameter" "public_zone_id" {
  name = "/NHS/deductions-${data.aws_caller_identity.current.account_id}/root_zone_id"
  type  = "String"
  value = aws_route53_zone.public.zone_id
}

output "public_zone_ns" {
  value = aws_route53_zone.public.name_servers
}
