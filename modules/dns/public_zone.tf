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

resource "aws_route53_zone" "non_prod_public" {
  name = "non-prod.patient-deductions.nhs.uk"

  tags = {
    CreatedBy = var.repo_name
  }
}

resource "aws_route53_record" "non_prod_ns" {
  name = "non-prod.patient-deductions.nhs.uk"
  ttl = 30
  type = "NS"
  zone_id = aws_route53_zone.public.zone_id

  records = aws_route53_zone.non_prod_public.name_servers
}

resource "aws_ssm_parameter" "non_prod_public_zone_id" {
  name = "/repo/output/${var.repo_name}/non-prod-public-zone-id"
  type  = "String"
  value = aws_route53_zone.non_prod_public.zone_id

  tags = {
    CreatedBy = var.repo_name
  }
}
