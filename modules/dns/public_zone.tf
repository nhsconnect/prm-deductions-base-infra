resource "aws_route53_zone" "public" {
  name = "patient-deductions.nhs.uk"

  tags = {
    CreatedBy = var.repo_name
  }
}

# Save the zone IDs to use them in other infra projects
resource "aws_ssm_parameter" "public_zone_id" {
  name = "/repo/output/${var.repo_name}/root-zone-id"
  type  = "String"
  value = aws_route53_zone.public.zone_id

  tags = {
    CreatedBy = var.repo_name
  }
}

output "public_zone_ns" {
  value = aws_route53_zone.public.name_servers
}
